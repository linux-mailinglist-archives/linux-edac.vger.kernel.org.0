Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42FF68BA
	for <lists+linux-edac@lfdr.de>; Sun, 10 Nov 2019 12:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfKJLhW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Nov 2019 06:37:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56682 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfKJLhW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 Nov 2019 06:37:22 -0500
Received: from zn.tnic (p200300EC2F26BB00DC95C53DC58BD1F9.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:bb00:dc95:c53d:c58b:d1f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 813B81EC095C;
        Sun, 10 Nov 2019 12:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573385836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8TAlmP8ZTd6fsyEb4l2OyXP0kwpjVffA/Tm1c3pVpU=;
        b=m398mtAEp0tj6XvjqLKKkTzJeQbFbvELvW+eztEthlDbWg1egvCL85MpLbIQs/cvyoGx/v
        2T7I9mpj8WjNyT5cV8nk1SEdryDkl7SUkfVotdxFbuUFC+UFZravZUUwhwJ4+eOuylaOI6
        S1+PVuhWtneDpi7o4R8A1boamU8ak9g=
Date:   Sun, 10 Nov 2019 12:37:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 03/20] EDAC: Introduce mci_for_each_dimm() iterator
Message-ID: <20191110113712.GA12627@zn.tnic>
References: <20191106093239.25517-1-rrichter@marvell.com>
 <20191106093239.25517-4-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106093239.25517-4-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 09:33:07AM +0000, Robert Richter wrote:
> @@ -702,6 +705,7 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
>  int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  			       const struct attribute_group **groups)
>  {
> +	struct dimm_info *dimm;
>  	int ret = -EINVAL;
>  	edac_dbg(0, "\n");
>  

drivers/edac/edac_mc.c: In function ‘edac_mc_add_mc_with_groups’:
drivers/edac/edac_mc.c:711:20: warning: unused variable ‘dimm’ [-Wunused-variable]
  struct dimm_info *dimm;
                    ^~~~

Pushing the declaration into the #ifdef CONFIG_EDAC_DEBUG block.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
