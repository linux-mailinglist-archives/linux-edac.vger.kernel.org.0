Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4372EB3644
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfIPIOR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 04:14:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfIPIOR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 04:14:17 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9m91-0002oP-LD; Mon, 16 Sep 2019 10:13:59 +0200
Date:   Mon, 16 Sep 2019 10:13:53 +0200 (CEST)
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
In-Reply-To: <e5a3fcc6a0184f729e57c34bc491805f@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1909161011560.10731@nanos.tec.linutronix.de>
References: <e5a3fcc6a0184f729e57c34bc491805f@zhaoxin.com>
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

On Wed, 11 Sep 2019, Tony W Wang-oc wrote:

> These functions are declared static and cannot be used in others
> .c source file. this commit removes the static attribute and adds
> the declaration to the header for these functions.

I'm not Cc'ed on any patches which use those functions. Please Cc the
relevant maintainers on all patches of such a patch series so contect can
be seen.

Also adding some hint to the change log which new code will use that would
be appreciated.

Thanks,

	tglx
