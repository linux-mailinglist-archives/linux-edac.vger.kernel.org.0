Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047FC4147FD
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhIVLmH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 07:42:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48842 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235596AbhIVLmH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 07:42:07 -0400
Received: from zn.tnic (p200300ec2f0efa008ea00e11d58cbc58.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:8ea0:e11:d58c:bc58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D7F71EC051E;
        Wed, 22 Sep 2021 13:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632310832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tei5VEk46/vgxQtg8qR60le/A/E3Os9/MyCI0V+1IWU=;
        b=erym6u3FYSc9xDzK/+A4ZS9nnNujVrv0n6pr3LTIz1VQqWyfdOS7zCQEXU9nOOami+kKSz
        SWdbJndsJ/z5rhu8bjtGOSGmpiLbjaDYuQqcDlUBFlZlpBj6G2MIcvGZvoHtQp4BycYgH/
        Ml7ZBpoiU5pw2FWxHqjBs8+VzsVmZzg=
Date:   Wed, 22 Sep 2021 13:40:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mukul Joshi <mukul.joshi@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUsWLw1gSD/AQbcH@zn.tnic>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
 <20210913021311.12896-2-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913021311.12896-2-mukul.joshi@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Sep 12, 2021 at 10:13:11PM -0400, Mukul Joshi wrote:
> On Aldebaran, GPU driver will handle bad page retirement
> even though UMC is host managed. As a result, register a
> bad page retirement handler on the mce notifier chain to
> retire bad pages on Aldebaran.
> 
> v1->v2:
> - Use smca_get_bank_type() to determine MCA bank.
> - Envelope the changes under #ifdef CONFIG_X86_MCE_AMD.
> - Use MCE_PRIORITY_UC instead of MCE_PRIO_ACCEL as we are
>   only handling uncorrectable errors.
> - Use macros to determine UMC instance and channel instance
>   where the uncorrectable error occured.
> - Update the headline.

Same note as for the previous patch.

> +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> +				    unsigned long val, void *data)
> +{
> +	struct mce *m = (struct mce *)data;
> +	struct amdgpu_device *adev = NULL;
> +	uint32_t gpu_id = 0;
> +	uint32_t umc_inst = 0;
> +	uint32_t ch_inst, channel_index = 0;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	struct eeprom_table_record err_rec;
> +	uint64_t retired_page;
> +
> +	/*
> +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> +	 * and error occurred in DramECC (Extended error code = 0) then only
> +	 * process the error, else bail out.
> +	 */
> +	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
> +		    (XEC(m->status, 0x1f) == 0x0)))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
> +	 */
> +	gpu_id = GET_MCA_IPID_GPUID(m->ipid) - GPU_ID_OFFSET;
> +
> +	adev = find_adev(gpu_id);
> +	if (!adev) {
> +		dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
> +				     __func__, gpu_id);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/*
> +	 * If it is correctable error, return.
> +	 */
> +	if (mce_is_correctable(m)) {
> +		return NOTIFY_OK;
> +	}

This can run before you find_adev().

> +static void amdgpu_register_bad_pages_mca_notifier(void)
> +{
> +	/*
> +	 * Register the x86 notifier only once
> +	 * with MCE subsystem.
> +	 */
> +	if (notifier_registered == false) {
> +		mce_register_decode_chain(&amdgpu_bad_page_nb);
> +		notifier_registered = true;
> +	}

I have a patchset which will get rid of the need to do this silliness -
only if I had some time to actually prepare it for submission... :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
