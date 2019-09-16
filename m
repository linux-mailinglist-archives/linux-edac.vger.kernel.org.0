Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4AB3784
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfIPJuj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 05:50:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfIPJuj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 05:50:39 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9neR-0008OJ-VN; Mon, 16 Sep 2019 11:50:32 +0200
Date:   Mon, 16 Sep 2019 11:50:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v3 2/4] x86/mce: Make 3 functions non-static
In-Reply-To: <966609ae83b947b998a85cd2fcc1f304@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1909161148220.10731@nanos.tec.linutronix.de>
References: <966609ae83b947b998a85cd2fcc1f304@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 16 Sep 2019, Tony W Wang-oc wrote:

> On Mon, Sep 16, 2019, Thomas Gleixner wrote:
> >On Wed, 11 Sep 2019, Tony W Wang-oc wrote:
> >
> >> These functions are declared static and cannot be used in others
> >> .c source file. this commit removes the static attribute and adds
> >> the declaration to the header for these functions.
> >
> >I'm not Cc'ed on any patches which use those functions. Please Cc the
> >relevant maintainers on all patches of such a patch series so contect can
> >be seen.
> >
> 
> Patches 3/4, 4/4 in this patchsets are using these functions. Specifically, 
> "[PATCH v3 3/4] x86/mce: Add Zhaoxin CMCI support " in this patchsets is
> using intel_init_cmci(), "[PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support"
> is using intel_init_lmce() and intel_clear_lmce().
> 
> I had sent all patches in this patchsets to your mailbox. Could you help to
> check again? Thank you.

Found them by now, but please make sure that you provide cover letter
[PATCH vX 0/N ] and thread the patches proper so they reference the cover
letter. git send-email does that for you.

Thanks,

	tglx
