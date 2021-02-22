Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01C53214F6
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBVLWf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 06:22:35 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:11970 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBVLWe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 06:22:34 -0500
X-AuditID: 0a580157-f39ff7000005df43-6b-60338d96af6a
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id C6.09.57155.69D83306; Mon, 22 Feb 2021 18:55:18 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 19:21:46 +0800
Date:   Mon, 22 Feb 2021 19:21:46 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222192146.76ffec84@alex-virtual-machine>
In-Reply-To: <20210222102206.GC29063@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
        <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
        <20210222173109.7b7ac42a@alex-virtual-machine>
        <20210222100356.GB29063@zn.tnic>
        <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXCFcGooDut1zjB4N99Y4vPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x/t9V9k8Pm+S8zjR8oU1gD2KyyYlNSezLLVI3y6BK6P97ivWghVsFYvmH2NpYPzC0sXIwSEh
        YCIx46VhFyMXh5DAdCaJBwd6WCCcV4wS11Y9ZOti5ORgEVCV6P/xnR3EZgOyd92bxQpiiwgo
        SXxdNJcJpIFZ4BCjxOFzL5hBpgoLhEosmVYIUsMrYCWx68NWRhCbU0BXYt63x8wQC7YxSfT8
        OcICkuAXEJPovfKfCcSWELCXaNuyiBGiWVDi5MwnYDXMAjoSJ1YdY4aw5SW2v50DZgsJKEoc
        XvKLHaJXSeJI9ww2CDtWYtm8V6wTGIVnIRk1C8moWUhGLWBkXsXIUpybbriJERIp4TsY5zV9
        1DvEyMTBCPQbB7OSCC/bXaMEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxijnwJQgLpiSWp2amp
        BalFMFkmDk6pBqaAG3m3tVkau/inJHq/mxb20/al5D4xEwvzvakZ+etynJ7MnKCqufjrrKqF
        PYY352ZfKQuW+OlgfzulgGfmqfJLm8M2qbpNebspOOni7/Kj5+KXq5wvO3fyycdP747t7tDa
        /qgxufichWLV1Kk1jlabTul9bflZdHj+k91zuLvMpOdNdXo28VZqYv/nbSVRSy/8MG2KOvvi
        4T/zlu78xcncUX+v8TY+6itQ7X34N6ggUU7/4+yi4tmHRVLX1llpvXt1VjJ8rnrS4j2zLzhO
        +RjRWtO9R96sSffBHNGnn93OSPv3rrfa57c8+51inFpU1v22O9XXPv7mEXj84P9Cp+jyvzdu
        rK21NbAPmPOgs61AiaU4I9FQi7moOBEA0vFLEQMDAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 11:22:06 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 22, 2021 at 06:08:19PM +0800, Aili Yao wrote:
> > So why would intel provide this MCG_STATUS_RIPV flag, it's better to
> > remove it as it will never be set, and all the related logic for this
> > flag is really needed ?  
> 
> Why would it never be set - of course it will be. You don't set it. If
> you wanna inject errors, then make sure you inject *valid* errors which
> the hardware *actually* generates, not some random ones.
> 

As far as I know, Most of RAS related tests are faked, not real errors, and it's really meaningful.

You should better reproduce the issue I tried to fix, or at least read the code more detailly and you will
know if it's random and invalid

Best Regards!
Aili Yao
