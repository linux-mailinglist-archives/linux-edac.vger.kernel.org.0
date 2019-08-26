Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32839D22A
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfHZO7J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 10:59:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730725AbfHZO7I (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Aug 2019 10:59:08 -0400
Received: from zn.tnic (p200300EC2F065700151C403A4EBA2CC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5700:151c:403a:4eba:2cc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FD251EC058B;
        Mon, 26 Aug 2019 16:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566831547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lyPGmPd5v4iVdl12WaU/uNVIbYt5hdCcXZcNjYUv204=;
        b=SSLnQ5dVp+wvHtszCOowYsZbPTjQzECygWh6I30y3Ma9yHvj2Zq/MaSiPnAnuohbQJbNpv
        qS/BBy3vWNxUjCvxBDZjngZW0j6sa2a8ifgEM/oCBBKv4RgwDY+fGl6WFhzL/RwDpmjrcm
        KuXuiDPcDlWU+0PMS3g2IovTlrB2pf4=
Date:   Mon, 26 Aug 2019 16:59:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190826145901.GH27636@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190823153739.GC28379@zn.tnic>
 <SN6PR12MB2639E02109E30165D4A37D8AF8A10@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639E02109E30165D4A37D8AF8A10@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 26, 2019 at 02:19:18PM +0000, Ghannam, Yazen wrote:
> I was tracking down the failure with ECC disabled, and that seems to be it.
>
> So I think we should return 0 "if (!edac_has_mcs())", because we'd only get
> there if ECC is disabled on all nodes and there wasn't some other initialization
> error.
>
> I'll send a patch for this soon.
>
> Adam, would you mind testing this patch?

You can't return 0 when ECC is disabled on all nodes because then the
driver remains loaded without driving anything. That silly userspace
needs to understand that ENODEV means "stop trying to load this driver".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
