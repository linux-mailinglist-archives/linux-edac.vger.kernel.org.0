Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC010CCFA
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1Qo6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Nov 2019 11:44:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56188 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfK1Qo6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Nov 2019 11:44:58 -0500
Received: from zn.tnic (p200300EC2F0E0600B5CC2C00F8056911.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:600:b5cc:2c00:f805:6911])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A5371EC0CFF;
        Thu, 28 Nov 2019 17:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574959496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ch/pKWNOmgtGhrnNKCZg5exIx/NmT3MFw/W9kMnBRmY=;
        b=oDwMaARcpAUQPYpJUcbLmU5+Fz/aTlVCCnrzU4fflYy5CVyFnouWtRBo6d9KT5shv+c6ZF
        ZK+BP8lyacbQp3x/2rKaoadB+1IrRBgTJiOK8sfvpJfm8pOtjPdPnWlFOKNFCDfAGLiesl
        FomkhqBK6mw3+Z+DwwDzTIyZBe1ypPk=
Date:   Thu, 28 Nov 2019 17:44:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Huangming (Mark)" <huangming23@huawei.com>
Subject: Re: linuxnext-20191127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Message-ID: <20191128164448.GF17745@zn.tnic>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
 <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
 <20191127205400.cip7hdbhcdokofel@rric.localdomain>
 <7131f2b9-d4c3-b858-2d17-c56003789df2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7131f2b9-d4c3-b858-2d17-c56003789df2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 28, 2019 at 11:02:32AM +0000, John Garry wrote:
> linuxnext-20191119 does not look to have the issue - that's when I
> cherry-pick your refcount fix - but has lots of memory leaks:

Can you forget linux-next for a while and test the latest Linus master
branch?

Also, pls send your .config and full dmesg. Privately's fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
