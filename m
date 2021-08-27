Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF13F9E13
	for <lists+linux-edac@lfdr.de>; Fri, 27 Aug 2021 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhH0Rhz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Aug 2021 13:37:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237087AbhH0Rhz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Aug 2021 13:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630085807;
        bh=nTR4iuVPmMGAXaXpmel+nekd8a2+COglF3GB0Y3BokA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Xj0ceu4uzMDri8vHPD4M+88HkanYzsPE3T1ha1BfamL9rdRH6XOhgRv0STcK9ZuRp
         d0TVMC6TSjs9m3JgNNEUFyB9rtGBmBeAhTAKmEI6jg8aRyNKiNnfIjKupeDXv4KMXw
         bnSpM3bImH8ydjlIZbEMzZty7wD1r0gyXLLK8GUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRVh-1mV0Sa0N4d-00XtPK; Fri, 27
 Aug 2021 19:36:47 +0200
Date:   Fri, 27 Aug 2021 19:36:33 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Len Baker <len.baker@gmx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Message-ID: <20210827173633.GA3040@titan>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic>
 <20210824090338.GB7999@titan>
 <YSU5wp/ZpsXuDgmu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSU5wp/ZpsXuDgmu@zn.tnic>
X-Provags-ID: V03:K1:JEqlwMVH6r3hWoS9kloc3KrglkJTJwAoWlVo2fLLTtKvjRpRX6o
 dU7eV+hcBX9GOgqqiO+nenAY32iusp2nmfkldMlDPUgRQwvGrWImH62x+iBUTSgIwyyyxle
 rGhJNAfpbEKM9aJo4xz8jQRyjpBK1gjmZ2OndaQg2KtGWvnuo5aNnKOYWcgg17Br4AtPEQQ
 1chVSUBR9ej0Un8jTmU+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bog80o/EQMA=:fEvY3VupqWgMiyNOuCvw5K
 MnyYTx/T3zlkyUvpDjOLv4V2g8IeTJy5AxDpW0hvY7Rsq0aJtL5Z9yx6nGgKGeWnUlw/o3zj1
 ZZeZ6dQPcutCv/7EKg+FI6TTclaPgXPJ+qMsOZddrO7S3lqYXnO+t06e1TwkvPv7HqsySiPex
 2yW0xPt8uq7P6yLO2BOqvvdFZTX6Rut9DwDTkJddGpB8akCnjb8uqulDFNSgcn5mOqzf+4/LG
 Zf7n+XDNWNzFZyScGYXCZM04oxexsYVXW8VlL/9LucX8KqLPkM981k4driNnVdT8uJskzhp0X
 owuSu/7Yjhj2UKgA/4wTJO/DPK4xcfR4SDi4y7YpU3bQ5cF2wb1cFJUrV1gdolWjvq/smNahH
 mVlz4K9NhLj+hLEA6VKF+C/GCLxiuRK7nuSACA/pARh8fn/JNuWVx2T2RPpVw4t/I8tFKhr7x
 0FA/v+S62emrJYa1H1ltUNmDGe7jcUqCFySr0kHhBfqyfRwZzsFzr8RwKv7s89Te31QUz4Djn
 yGvjZyYrbY4r1RfNr0iC7m1KYT67BCAa8s4mA8M/STkjxdGm0FDjROuUVhaf7ui1uOejUgKUX
 24rfeuP18ZnPcM2KyIxh4KcQLQ5suduLbBgRjMcwqerbkKrbhbFEUgsuZ/035sQ6AhtMd6vAy
 8IGUaHjVk5tu+zUfgKkJDcT4GCY5+KVMRwgq+B5NDizMNVtz122acl+soOzWFLp/Fg+xzqtew
 oKqlrjjMYcEHe3ZQdbM7LqLg0Q3Goydfy0Es5xHaTlXhNUzihQdSytYpV3aS49gxtK3KsPBji
 PvZtGuq8pKdUtWxZUCQ/cGRn41nFbdN0dB7aRiHwLMilmTaWslTWUdmghtRNubybG1Sc/Jf3U
 roT589Wm7kg29iZGOHmrhzLOnUM4uSUFJ6hYaPmHa6Vhds2mDUBLYZcYYnkJBzauqfvZDHjcL
 qJEopzBSftXuVUxIxvK028xk7MEezrLZ17IygQCMWC230cJ+mvzst1aTosYSyal9tsqsSjcF7
 q6Jvzhnr+uvvg1e1y9aFBFbC3E+V/H+9TcJ0ZsD8CZTw44Sm48ONlg11CdotVO/AsvOTK36+h
 InvEi1JZ/itVVygCaNzoX1NtQde3l4G+GOz7a3CdlZSu3yMNg3RS3rLHw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Tue, Aug 24, 2021 at 08:26:10PM +0200, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 12:28:07PM +0200, Len Baker wrote:
> > This is a task of the KSPP [1] and the main reason is to clean up the
> > proliferation of str*cpy functions in the kernel.
>
> That I understood - you prominently explain where the patches stem from.
>
> What I can't parse is that formulation "previous step". What previous
> step do you mean?

Well, the main purpose is to clean up the proliferation of str*cpy functio=
ns.
One task is to remove the strcpy uses: The first step (previous step) woul=
d
be to remove all the strcpy uses. Then, as a second step remove all the
strcpy implementations.

I hope that this clarify your question.

Regards,
Len
