Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049C5B3BD1
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfIPNtb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 09:49:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733243AbfIPNtb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 09:49:31 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rNT-0007Lt-H4; Mon, 16 Sep 2019 15:49:15 +0200
Date:   Mon, 16 Sep 2019 15:49:09 +0200 (CEST)
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
Subject: Re: [PATCH v3 0/4] x86/mce: Add supports for Zhaoxin MCA
In-Reply-To: <a26cd9adb0b74b838c30ff9299de9932@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1909161539510.1887@nanos.tec.linutronix.de>
References: <a26cd9adb0b74b838c30ff9299de9932@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 16 Sep 2019, Tony W Wang-oc wrote:

> Zhaoxin newer CPUs support MCE, CMCI and LMCE that compatible with
> Intel's "Machine-Check Architecture".

Thanks for providing a cover letter. Though threading does not work either
with that simply because the 1-4/4 mails lack a

   References: <Message-id-of-cover-letter>

tag. They have some weird:

   Thread-Index: AdVsgZ9UPwR7QKdtRlW4qXXe20fCvg==

tag, but that is different for every mail.

   Thread-Index: AdVsghaYSu2N9NgNSwS4zHAPRb3wjg==

'Thread-Index' is a MS Outlook specific header which is not supported by
real MUAs.

Please make sure to fix that when you are going to send the next round of
patches. Send them to yourself first and check the mail headers for a
proper References: tag chain. If you want to know how that looks just have
a look at the mail headers of any properly threaded patch series which you
received from LKML.

Thanks,

	tglx


