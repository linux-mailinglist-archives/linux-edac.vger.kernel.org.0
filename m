Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC6426F44
	for <lists+linux-edac@lfdr.de>; Fri,  8 Oct 2021 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJHQrc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Oct 2021 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJHQra (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Oct 2021 12:47:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2053C061570;
        Fri,  8 Oct 2021 09:45:33 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d5600b5f996c39c66b7a4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:b5f9:96c3:9c66:b7a4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4A8C1EC04E4;
        Fri,  8 Oct 2021 18:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633711531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=skxt32l6VMLc1SQegT7KPtFR1sOOv8n10kZQ1BLvDMA=;
        b=Gohl9o8rgSUdCt7aiu2nEKmOqvpLNkSqLskxoA/cclKJswpRRPS/k++WmOiDXTUoM88jz+
        Zr8ozvRchuxKlAKRCQbNMxzHpTzLNuUWpgI3BbERoftVd6E5xdHK/o3zBLOifY1F4wcUQ8
        mGy24y8ac61Fxc6ESJVga6gFxxnZA8o=
Date:   Fri, 8 Oct 2021 18:45:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] x86/mce: Define function to extract ErrorAddr from
 MCA_ADDR
Message-ID: <YWB1qDzwUvdDkjFz@zn.tnic>
References: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
 <eb77b76f-742e-c9b5-982c-00f293a1620a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb77b76f-742e-c9b5-982c-00f293a1620a@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 13, 2021 at 02:19:33PM -0500, Smita Koralahalli Channabasappa wrote:
> Hi all,
> 
> Do you have any other comments which I need to address on these set of patches?

You probably should rediff them against latest tip/master and send a new
version.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
