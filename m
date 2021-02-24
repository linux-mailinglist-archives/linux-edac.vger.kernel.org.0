Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53158323A0B
	for <lists+linux-edac@lfdr.de>; Wed, 24 Feb 2021 10:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhBXJ6C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Feb 2021 04:58:02 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45292 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234829AbhBXJ52 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Feb 2021 04:57:28 -0500
X-AuditID: 0a580157-f39ff7000005df43-0a-60361c8fe966
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 4F.E4.57155.F8C16306; Wed, 24 Feb 2021 17:29:51 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 24 Feb
 2021 17:56:33 +0800
Date:   Wed, 24 Feb 2021 17:56:32 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20210224175632.5d99abcc@alex-virtual-machine>
In-Reply-To: <434eba7a568a4b9f8eb7ee11a5c8b04f@intel.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
        <20201120172235.620eb826.yaoaili@kingsoft.com>
        <20201120102422.GA712@zn.tnic>
        <20210128200128.6f022993.yaoaili@kingsoft.com>
        <e9645a3ff93e46d4aabdf7dd45bfc4d7@intel.com>
        <20210223171809.7df62b08@alex-virtual-machine>
        <434eba7a568a4b9f8eb7ee11a5c8b04f@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXCFcGooNsvY5Zg8GGfssXnDf/YLO7vW85k
        sfPhWzaL5fv6GS0unGpgsjhz+hKrxZsL91gc2D2+t/axeKyZt4bRY/Gel0wem1Z1snlsudrO
        4vF5k1wAWxSXTUpqTmZZapG+XQJXRsuLb6wF89grnh2YxNrAeJi1i5GDQ0LARGLNG6EuRi4O
        IYHpTBITryxjhHBeMUpcm3SLvYuRk4NFQFWi4+U2VhCbDcjedW8WmC0ioCZxafEDZpAGZoEL
        TBLLZv5lAUkIC1hJPN3wBszmBbIvNu4DG8QpYCnx+Ow3dogN75klFp1YBZbgFxCT6L3ynwnE
        lhCwl2jbsogRollQ4uTMJ2CDmAV0JE6sOsYMYctLbH87B8wWElCUOLzkFztEr5LEke4ZbBB2
        rMSyea9YJzAKz0IyahaSUbOQjFrAyLyKkaU4N91wEyMkMsJ3MM5r+qh3iJGJg/EQowQHs5II
        7+Z/pglCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQO3mSQICaQnlqRmp6YWpBbBZJk4OKUamBYU
        Fex9+9nXeqVu8zblyJqXjZN/1h1f4iV8cdrfHVf1tni53mFZdYrTd+6k2DDvNx/DTm3b/9xj
        6qeFS3mDv1T22k++s+OExZs6F60krQ0iVe8WXG6761VvfJ1L7fbfCaIfxbYWOZ9YZ7xBzPb4
        3HcrTuYtmx5Uu5s9pWvdL+FUlYhzKze9t4qp3jy3bN1WS5lva7VyLf27uatqyhufnZZTS8hO
        0PXmmPOm76P2JaUpNdw/Tm162XY3P5br1Ic5E0UWNDM/3RlfYLTH/Bs/+8bTWo3/7bZscFi8
        xsSoqP7ZxlWuj/+LGixWmXj9wvrkyiopOYemgkmTFr7jXTeLS/Zg2Yown99zdAtPsZqxF6Qq
        sRRnJBpqMRcVJwIAaRl+D/sCAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 23 Feb 2021 19:32:37 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > I am not smart enough to get the point. I have paid a lot of time for this patch, 
> > I need an result even it doesn't work. so i like the reply like this:
> >
> > 1. this patch is meaningless, and should be rejected.   
> > 2. this issue is real, but we need other methond, not this patch.
> > 3. the patch need to improve.  
> 
> I don't want to say that the patch is meaningless ... it may be useful to you
> in your environment to help sort out machine checks due to h/w issues vs.
> programming errors in the machine check recovery code.
> 
> But I don't think it is generally useful in the upstream code.

Got it.
Another thing I want to say is that when mca_cfg.tolerant is set to 3, this NMI handling will
also panic the system in some case, but it seems there is not a big influence though.

Thanks
Aili Yao  

