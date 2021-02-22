Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A42321326
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBVJcS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 04:32:18 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:44947 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230179AbhBVJcJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 04:32:09 -0500
X-AuditID: 0a580157-f39ff7000005df43-c6-603373aaf480
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id E4.A7.57155.AA373306; Mon, 22 Feb 2021 17:04:42 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 17:31:09 +0800
Date:   Mon, 22 Feb 2021 17:31:09 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222173109.7b7ac42a@alex-virtual-machine>
In-Reply-To: <20210222092403.GA29063@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
        <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXCFcGooLuq2DjBYPFvaYvPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x/t9V9k8Pm+S8zjR8oU1gD2KyyYlNSezLLVI3y6BK2PCnISCCSwVC65PYWpgnM3cxcjJISFg
        InFwTjdrFyMXh5DAdCaJjUfnsEE4rxgl1s+bxgJSxSKgKtH9/DIriM0GZO+6NwvMFhFQkvi6
        aC4TSAOzwCFGicPnXgCN5eAQFgiVWDKtEKSGV8BKYvW6H2BzOAV0JW4v+c4IsaCPUeLxrR9g
        g/gFxCR6r/xngjjJXqJtyyJGiGZBiZMzn4A1MwvoSJxYdYwZwpaX2P52DpgtJKAocXjJL3aI
        XiWJI90z2CDsWIll816xTmAUnoVk1Cwko2YhGbWAkXkVI0txbrrhJkZIpITvYJzX9FHvECMT
        ByPQbxzMSiK8bHeNEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzijnyJQgJpCeWpGanphakFsFk
        mTg4pRqYNjgJLT6cMrnqyMVLJo+nWDDd/GDasMDImXffJetzPBNutlXFbpfu3L9jzsOqjTl2
        ZYpG2YVK8gL/HmbfndAZWPOQ1X2Gy/V3098Y3i3y85h2xkLEwSfB5dDtKVaS4W879zf+FlvX
        qiqznW87737jiSU7EtOPTd50RJ1TJd5O2Xbe823vW6d7627n+ahpz/pH2Sjl222N9IbfSnfL
        53p9cc6YWuARc1fp2ym17XMXWng7e2dPyflb6G0S1nNq3e7CmT+bbfeFbovwrFe4em3HhDsn
        j/Y/ufa/RbEi9uGLc30Cm9ky7rKb+6lZrVJPMddZ9obp4YWPZtHffE/xJn6Z2a9zd9kGn78a
        FuoM1ku4lViKMxINtZiLihMB2B5wfgMDAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 10:24:03 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 22, 2021 at 11:50:07AM +0800, Aili Yao wrote:
> > From commit b2f9d678e28c ("x86/mce: Check for faults tagged in
> > EXTABLE_CLASS_FAULT exception table entries"), When there is a
> > memory MCE_AR_SEVERITY error with no return ip,  
> 
> What is a "no return ip" - MCG_STATUS_RIPV?

yes 

> How do you trigger this error?

you can inject a memory UE to a VM, it should always be MCG_STATUS_RIPV 0.

Best Regard!
Aili Yao
