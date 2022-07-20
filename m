Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0D57BAF5
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGTP6E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTP6D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 11:58:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D84B0E3;
        Wed, 20 Jul 2022 08:58:01 -0700 (PDT)
Received: from zn.tnic (p200300ea97297623329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7623:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDF2F1EC04C2;
        Wed, 20 Jul 2022 17:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658332675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9FGXIDVQys+1yUZO4AwCM1llCdChh/h0Uv7yIHs9V0E=;
        b=FDLo7jCiVmuQaPxUn9tfOtacPGYhMWG2KWMc5u9/JYJhhI3mLd+sKGwT8Puew7JVN02eUG
        gYS/bMUncYOG2Op/tP3OLmbrpCcMOIRjAH9lry5yNaruz39qT35XVeeZtcQh4/QnPXGtJf
        cADT+Rz/etgAm6q8n+So0Q4qC0W0xWo=
Date:   Wed, 20 Jul 2022 17:57:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "rrichter@marvell.com" <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <YtgmALzpaR9IHR/F@zn.tnic>
References: <20220719220124.760359-1-toshi.kani@hpe.com>
 <YtfsOcWbWREu1NnK@zn.tnic>
 <PH7PR84MB1838CC03943D28806F7DCD8F828E9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1838CC03943D28806F7DCD8F828E9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 20, 2022 at 03:41:20PM +0000, Kani, Toshi wrote:
> SMBIOS handle is correct.
> 
> In dimm_setup_label(), *device is set but *bank is null (dmi_empty_string).
> *bank is set from SMBIOS type 17 Bank Locator, offset 11h.  This value is
> set to 0x0 (null string) on this system, as shown below.
> 
> Handle 0x0020, DMI type 17, 84 bytes
> Memory Device
>         Array Handle: 0x0013
>         Error Information Handle: Not Provided
>         Total Width: 72 bits
>         Data Width: 64 bits
>         Size: 32 GB
>         Form Factor: DIMM
>         Set: None
>         Locator: PROC 1 DIMM 1        <===== device
>         Bank Locator: Not Specified   <===== bank

I think it'll be more user-friendly to put

"PROC 1 DIMM 1" for device

and

"NA" or so for bank

instead of setting the label to the NULL string.

I.e., relax that

	if (bank && *bank && device && *device)

check there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
