Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13F3213D3
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 11:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBVKKs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 05:10:48 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:44953 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230419AbhBVKJ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 05:09:29 -0500
X-AuditID: 0a580155-6fbff700000550c6-01-60337b96ff01
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 6F.A4.20678.69B73306; Mon, 22 Feb 2021 17:38:30 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 18:08:19 +0800
Date:   Mon, 22 Feb 2021 18:08:19 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222180819.3998fe33@alex-virtual-machine>
In-Reply-To: <20210222100356.GB29063@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
        <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
        <20210222173109.7b7ac42a@alex-virtual-machine>
        <20210222100356.GB29063@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXCFcGooDut2jjBYG2fhMXnDf/YLKZtFLe4
        cKqByeLyrjlsFpcOLGCy2LxpKrPFmwv3WCx+bHjM6sDh8b21j8Vj8Z6XTB6bVnWyebw7d47d
        4/2+q2wenzfJeZxo+cIawB7FZZOSmpNZllqkb5fAlfFm11u2gmcsFfvOfGdpYHzI3MXIySEh
        YCLR+fIQkM3FISQwnUni26vf7BDOK0aJn48/sYJUsQioSvy6NAPMZgOyd92bBWaLCChJfF00
        lwmkgVngEKPE4XMvgEZxcAgLhEosmVYIUsMrYCWx++8jNhCbU0BX4urF20wQCx4xSlx4tRns
        DH4BMYneK/+ZIE6yl2jbsogRollQ4uTMJywgNrOAjsSJVceYIWx5ie1v54DZQgKKEoeX/GKH
        6FWSONI9gw3CjpVYNu8V6wRG4VlIRs1CMmoWklELGJlXMbIU56YbbWKExEroDsYZTR/1DjEy
        cTAC/cbBrCTCy3bXKEGINyWxsiq1KD++qDQntfgQozQHi5I4b7kDX4KQQHpiSWp2ampBahFM
        lomDU6qByXnmxIOTEwRLjbe/ufukY/o+kRtaM2edTg1pS4ufuFJW1zJn/wdm/32H/dz8qg9+
        4xeZeeh9R2rZJUb3uTzFeUevcd7bNK3P5P1BbYlTOrICgtl2dsc9X2xznDbnYJfOnKrgpF3z
        He8mbpKbZVY4V8r+4je7G55yN2OiVVv22K263J1xqvmvvaWyx8dTmunqNwqzLi150L/EL+hA
        y4yYtUI/05QPrbJk5pNYMVlTvPbjCmtHwUdeE2/eXFPhabYy8OeZ3YuE79xiujrt/LNGQa9T
        v+Z8nyF97J3vjLqLs+6W/H5jK/r+odyJH1GLjkz9G20pNu1iYZtu3nO/DL+XZ9U6ax32761Z
        +Kaq57dAaZgSS3FGoqEWc1FxIgDeYsNxBAMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 11:03:56 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 22, 2021 at 05:31:09PM +0800, Aili Yao wrote:
> > you can inject a memory UE to a VM, it should always be MCG_STATUS_RIPV 0.  
> 
> So the signature you injected is not something the hardware would
> generate - you just didn't set MCG_STATUS_RIPV.
> 
> If so, why should the code handle invalid signatures which the harware
> cannot generate?
> 

So why would intel provide this MCG_STATUS_RIPV flag, it's better to remove it as it will
never be set, and all the related logic for this flag is really needed ? 
