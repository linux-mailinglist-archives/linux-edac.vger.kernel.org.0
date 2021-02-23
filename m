Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E34322978
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 12:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhBWL2A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 06:28:00 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45156 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230142AbhBWL17 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 06:27:59 -0500
X-AuditID: 0a580157-f21ff7000005df43-d3-6034e054e921
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 22.67.57155.450E4306; Tue, 23 Feb 2021 19:00:36 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 23 Feb
 2021 19:27:11 +0800
Date:   Tue, 23 Feb 2021 19:27:11 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210223192711.0b517745@alex-virtual-machine>
In-Reply-To: <20210223100538.GB26060@zn.tnic>
References: <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
        <20210223102755.13cbdffd@alex-virtual-machine>
        <20210223094300.GA26060@zn.tnic>
        <20210223175640.5708c7ed@alex-virtual-machine>
        <20210223100538.GB26060@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXCFcGooBvywCTB4PEXfYvPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x/t9V9k8Pm+S8zjR8oU1gD2KyyYlNSezLLVI3y6BK+PX3ntsBTeYKyZ1fGBuYHzB1MXIySEh
        YCJx8/Zn5i5GLg4hgelMEqv/f2OEcF4xSpx5eJ4NpIpFQFXiff8BsA42IHvXvVmsILaIgJLE
        10VzmUAamAXuMEr86ZkGNIqDQ1ggVGLJtEKQGl4BK4mbr1eD1XMK6EpM7XvEBLHgHrPEpPXX
        2UES/AJiEr1X/kOdZC/RtmURI0SzoMTJmU9YQGxmAR2JE6uOMUPY8hLb384Bs4UEFCUOL/nF
        DtGrJHGkewYbhB0rsWzeK9YJjMKzkIyahWTULCSjFjAyr2JkKc5NN9zECImV8B2M85o+6h1i
        ZOJgPMQowcGsJMLLdtcoQYg3JbGyKrUoP76oNCe1+BCjNAeLkjhv4DaTBCGB9MSS1OzU1ILU
        IpgsEwenVAOTlUvRZAM+6TqluN85utzNFuabbUNb7eV2T03hnbnBl0Vjyjr51wf0wm/5nD99
        9hG7seT5O9Gqrqd8VabuOrSp+t6Eiw6fWuO1WmwW3Urjl+DQcfnduUo9fAmzhvM3hTieyNff
        K1c6v9ywoGbC1+VbtsTsuCz398j1IzM7p6xpyPtrf/TYGbGjV3Occ269/aj29cdSNbEfgeXn
        /nS1TinerNqo9mlboGW+zeHea8Wnj+58X/S91bBtVuOZV+xCD7R1Z/vtuNacdeq1ygujRXt9
        DummMDPbTPtwvevo65uJ13+yPLnTd7Z50uGNm+/IN/24nd5vc7/+wfQnTVvrDMQnXamSaFli
        cs7r2s/mbt2D75RYijMSDbWYi4oTAXIoh7QEAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 23 Feb 2021 11:05:38 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 23, 2021 at 05:56:40PM +0800, Aili Yao wrote:
> > What i inject is AR error, and I don't see MCG_STATUS_RIPV flag.  
> 
> Then keep debugging qemu to figure out why that is.
> 

What I think is qemu has not an easy to get the MCE signature from host or currently no methods for this
So qemu treat all AR will be No RIPV, Do more is better than do less.

Thanks
Aili Yao
