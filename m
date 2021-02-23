Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B51322421
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 03:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBWC2q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 21:28:46 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12074 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhBWC2q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 21:28:46 -0500
X-AuditID: 0a580157-f21ff7000005df43-56-603461f427ae
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 97.10.57155.4F164306; Tue, 23 Feb 2021 10:01:24 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 23 Feb
 2021 10:27:56 +0800
Date:   Tue, 23 Feb 2021 10:27:55 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210223102755.13cbdffd@alex-virtual-machine>
In-Reply-To: <20210222124550.GB10880@zn.tnic>
References: <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
        <20210222173109.7b7ac42a@alex-virtual-machine>
        <20210222100356.GB29063@zn.tnic>
        <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXCFcGooPsl0STBYMZTFovPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x/t9V9k8Pm+S8zjR8oU1gD2KyyYlNSezLLVI3y6BK6Oh/SZzQS9vxezvfg2M87m6GDk5JARM
        JNpvXmTtYuTiEBKYziTx8fcbdgjnFaPEyjNLmEGqWARUJTbu7GMCsdmA7F33ZrGC2CICShJf
        F81lAmlgFrjDKPGnZxpQAweHsECoxJJphSA1vAJWEn8aDjOC2JwCuhKNs9cwQyy4xyzx7cYe
        dpAEv4CYRO+V/0wQJ9lLtG1ZxAjRLChxcuYTFhCbWUBH4sSqY8wQtrzE9rdzwGwhAUWJw0t+
        sUP0Kkkc6Z7BBmHHSiyb94p1AqPwLCSjZiEZNQvJqAWMzKsYWYpz0w03MUIiJXwH47ymj3qH
        GJk4GA8xSnAwK4nwst01ShDiTUmsrEotyo8vKs1JLT7EKM3BoiTOK+bIlyAkkJ5YkpqdmlqQ
        WgSTZeLglGpgYl+0MLf1VurJf22v2786ZE1KyO5kWLTu4Q4R+2VMnXo/7TjkauumeTS2uvXK
        eD+8aJKRnKDgyysb7TWxt/Xf1WvlKw7OvjBZZs+amIM6kt8ZjnX+2v9nz8pvR17stUzombxB
        X29KqPu6XqvsRSlnlWRWyWrP3NQeuTez4Yu+zrwLmcpLL3U/evApk/Hbx0dXN13jXPTP10lP
        +5zDSbG9tt9SNkWeyv0UNUV3qtKNV2en+/GXXri9+fdOPg/nLnHvW5ve9E+OvHBopsCt5Ks7
        Pe09L53hqa+92C7jUXxx1cJ727j1Cv9cXhlqJPv80I2r1tY8DJrLJvzSFlgkZLRLqlph8fza
        qXPPPLbpWGo4+40SS3FGoqEWc1FxIgBrJabIAwMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 13:45:50 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 22, 2021 at 08:35:49PM +0800, Aili Yao wrote:
> > Guest VM, the qemu has no way to know the RIPV value, so always get it
> > cleared.  
> 
> What does that mean?
> 
> The guest VM will get the MCE signature it gets from the host kernel so
> the host kernel most definitely knows the RIPV value.

When Guest access one address with UE error, it will exit guest mode, the host
will do the recovery job, and then one SIGBUS is send to the VCPU and qemu will
catch the signal, there is only address and error level no RIPV in signal, so qemu will
assume RIPV is cleared and inject the error into guest OS.

> It looks like you're testing how guests will handle MCEs which the host
> has caught and wants to inject into the guest for further handling. What
> is your exact use case? Please explain in detail how I can reproduce it
> step-by-step locally.

Yeah, there are multiple steps i do:
1. One small test code in guest OS access one address A which will be injected UC error,
   the address will be logged, and use vtop you can get the guest physical address.

2. Using "virsh qemu-monitor-command guest --hmp gpa2hvagpa2hva 0xxxxxx" to get the user
   virtual address,

3. Using vtop you can get host physical address from the above user address.

4. Inject 0x10 level error using einj module.

5. then when guest access the address, you will see what happens.

Please using latest upstream kernel for guest OS, and you may change monarch_timeout to a bigger
value, or you will see other issues not only talked one.

Tks

Best Regards!
Aili Yao
