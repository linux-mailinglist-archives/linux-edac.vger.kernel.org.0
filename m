Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C614BB7AE
	for <lists+linux-edac@lfdr.de>; Fri, 18 Feb 2022 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiBRLHV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Feb 2022 06:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiBRLHU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Feb 2022 06:07:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B812A22B1;
        Fri, 18 Feb 2022 03:07:03 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 441AF1EC0523;
        Fri, 18 Feb 2022 12:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645182418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c4c6I8GLhkF9RWrXeinlmv4me3VZ4wvoVq26Nzv3b44=;
        b=lvRpPmqmF5peidcetEaGgL9OJ/9OdTFCY75wemCra+JHqNRGOEugflNH76wwA7UH+rDLYH
        CvZwjmm7hP6hm4p7fOGxq80nZe1aoTqohfMdePVnvPecduIRC+bRnCZqkAOlZXsxmDWoy0
        xNJtv02U06mRVEOCXXTaRpjn9F19eI4=
Date:   Fri, 18 Feb 2022 12:07:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <Yg992OrUbfmtRizs@zn.tnic>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 17, 2022 at 09:28:09AM -0800, Luck, Tony wrote:
> I've been sitting on some partially done patches to re-work
> storm handling for Intel ... which rips out all the existing
> storm bits and replaces with something all new. I'll post the
> 2-part series as replies to this.

Which begs the obvious question: how much of that code can be shared
between the two?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
