Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C9A26090
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2019 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEVJeo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 May 2019 05:34:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42088 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfEVJeo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 May 2019 05:34:44 -0400
Received: from [107.16.110.78] (unknown [107.16.110.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 414591EC0965;
        Wed, 22 May 2019 11:34:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558517682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3izjwU4H+ed0Lx89lhZ2+zPs5hKdeDHBkD/yDroCiJ0=;
        b=Dn6jOkZ98dpIKjY0a1A7Twa5op57l4EW8a1VlK9DN5PR5QH4rrtfU3PQkb95NHbYPtew9e
        I6NHBdAjswV0/BzLXsEqXxLbvvdQNvPqrYGnaK+Zg+GLHPp79ZDWUljfSoiydKHjo/Ty3s
        dtunNB9V8Azcd1bp9jpi1Z6YvRX5XYA=
Date:   Wed, 22 May 2019 04:34:38 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <1c7eb8ab-6f48-c41a-1d3a-a9b0f5ce8a7f@arm.com>
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com> <1557142026-15949-2-git-send-email-yash.shah@sifive.com> <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com> <20190521182132.GB7793@cz.tnic> <1c7eb8ab-6f48-c41a-1d3a-a9b0f5ce8a7f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
To:     James Morse <james.morse@arm.com>
CC:     Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <ABA6726C-CC1D-4092-887E-7D5A5B90509B@alien8.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On May 22, 2019 4:13:59 AM CDT, James Morse <james=2Emorse@arm=2Ecom> wrote=
:
>Hi Boris,
>
>On 21/05/2019 19:21, Borislav Petkov wrote:
>> On Tue, May 21, 2019 at 11:00:59AM +0530, Yash Shah wrote:
>>> The prerequisite patch (sifive_l2_cache driver) has been merged into
>>> mainline v5=2E2-rc1
>>> It should be OK to merge this edac driver now=2E
>>=20
>> James?
>
>Still fine by me:
>Reviewed-by: James Morse <james=2Emorse@arm=2Ecom>
>
>(=2E=2E=2Ethis patch already has my reviewed-by on it=2E=2E=2E)
>
>I commented that it couldn't be merged in pieces here:
>https://lore=2Ekernel=2Eorg/lkml/4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm=
=2Ecom/T/#u
>
>which is what Yash is replying to=2E

Ok, I'll take it when I get back=2E Thanks for clarifying=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
