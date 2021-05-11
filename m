Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED837827B
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 12:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEJKfx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 May 2021 06:35:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhEJKeU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 May 2021 06:34:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fdy4W51KszkY1f;
        Mon, 10 May 2021 18:30:35 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 10 May 2021 18:33:09 +0800
Date:   Tue, 11 May 2021 10:44:40 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mchehab+huawei@kernel.org>
Subject: Re: [RFC PATCH] x86/mce/inject: Fix printk deadlock causing
 mce_timed_out panic
Message-ID: <20210511024440.GA186630@localhost.localdomain>
References: <20210509053229.GA2477949@localhost.localdomain>
 <YJahM9PaZ7Jefkbi@zn.tnic>
 <20210510200424.GA4056660@localhost.localdomain>
 <YJj+hHBEi8sYMp79@zn.tnic>
 <YJkAikroIpzN1Fl3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJkAikroIpzN1Fl3@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 10, 2021 at 11:44:42AM +0200, Borislav Petkov wrote:
> + Mauro.
> 
> On Mon, May 10, 2021 at 11:36:04AM +0200, Borislav Petkov wrote:
> > On Tue, May 11, 2021 at 09:33:10AM +0800, Lv Ying wrote:
> > > This panic happend on 4.18 kernel
> > 
> > When you report bugs and send patches to lkml and maintainers, *always*
> > do that against the latest upstream version.
> > 
> > This is not the first time people from Huawei send bug reports and
> > "fixes" for old kernels.
> > 
> > Please let your colleagues and whoever else at Huawei is sending patches
> > and reporting bugs - *always* test and report bugs against the latest
> > upstream kernel - not some old version!
> > 
> > If you want bugs against
> > 
> > 4.18.0-147.5.1.6.h429.eulerosv2r10.x86_64
> > 
> > fixed, go report that to whoever has made that kernel - not upstream.
> > 
> > Now, if you want to improve the upstream kernel and can trigger the same
> > thing with the upstream kernel, pls give the *exact* full information I
> > asked you before so that I am able to reproduce that here independently
> > and then we can take it from there.
> > 
> > HTH.
>

Boris, thanks again for your time to explain the detailed and standard
upstream bug report process.
Next, I will test on the latest upstream kernel(indpendent to any distro).
If I can reproduce this problem, I will send detailed test script.

Thanks
Lv Ying
