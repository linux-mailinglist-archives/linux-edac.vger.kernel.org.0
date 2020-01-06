Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26321315E5
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 17:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAFQRl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 11:17:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQRl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 Jan 2020 11:17:41 -0500
Received: from zn.tnic (p200300EC2F270F00B18FEB7C8E4C4E0C.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:f00:b18f:eb7c:8e4c:4e0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B9081EC068C;
        Mon,  6 Jan 2020 17:17:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578327459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0VhAvEHXgKym7Mcc4FcNCW/WIlO2xc2jAKlwcb5C37U=;
        b=E0L91l5Uix1tZoShcI7k9Nr6292MqiZkct8QcB/wmkydc/VcHGIDGEdySYT777AoFQK5Et
        3cY6qSdQUOzif/D3X4MLy0zxdECZym2U+QgteKNnQH8gdWHoRmHHysoH6lsY+UzzYMbBbF
        DHltfGVV+k9u3Feu4YCF97nt7zIKrQg=
Date:   Mon, 6 Jan 2020 17:17:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     'Aristeu Rozanski' <aris@redhat.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200106161732.GF12238@zn.tnic>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106151242.vkdiiwhubmkx5osh@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 06, 2020 at 10:12:42AM -0500, 'Aristeu Rozanski' wrote:
> The other option I can think about is just allowing the module to load
> in this situation: the CPU is present but you have no memory controller
> PCI devices present. Some drivers will allow loading without having a
> device present without errors. It's not clean as having to come up with
> something modutils can pick up as hint to not try to load more than once.

Yeah, but having a driver loaded when there's no hw to drive is also not
pretty.

> Or could just downgrade this specific message since it's a very common
> case and let the more unusual situations report more than once.

Yap, we did a similar thing for adm64_edac:

7fdfee926be7 ("EDAC/amd64: Get rid of the ECC disabled long message")

but instead of downgrading prio we actually went and killed it directly.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
