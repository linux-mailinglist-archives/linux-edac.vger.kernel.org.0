Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1D480011
	for <lists+linux-edac@lfdr.de>; Mon, 27 Dec 2021 16:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhL0Pmx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Dec 2021 10:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhL0PlC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Dec 2021 10:41:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD6C06175B;
        Mon, 27 Dec 2021 07:39:43 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B1A61EC04DE;
        Mon, 27 Dec 2021 16:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640619578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVeaMo/UI0cU46Vp+S4TD+kWGM95e4/LUlb6vGb15pU=;
        b=nQcdQaMFVFoGHpa8Lx9yAQV7NwmDTdMIWFcuxBS6WqHQnhCdiazSTDASFL0RK4kNb6cXTQ
        BylPjUodSzcEuAnX5H5jBKgh8kCb68j/6PHVrhoPGzoo8eoi55QKX44wPg7DlyGEX3TP3o
        dxn29NAM1QiexmlP2HVOA1iWqviePZM=
Date:   Mon, 27 Dec 2021 16:39:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?5byg5a2Q5YuLKFpoYW5nIFppeHVuKQ==?= <zhangzixun1@oppo.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A stack overflow found in flags_write()
Message-ID: <YcnePfF1OOqoQwrX@zn.tnic>
References: <TY2PR02MB2815A59F6B963F9C068CBB8A8E429@TY2PR02MB2815.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR02MB2815A59F6B963F9C068CBB8A8E429@TY2PR02MB2815.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 27, 2021 at 11:59:37AM +0000, 张子勋(Zhang Zixun) wrote:
> Hi,
> I find a problem in flags_write() in arch/x86/kernel/cpu/mce/inject.c. There is a parameter cnt in this function and it used in compute write size by "buf[cnt - 1] = 0". If cnt == 0, buf[cnt - 1] will change buf[-1] and occur overflow. This problem can be fixed by patch I provided.
> 
> Thanks
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人使用（包含个人及群组）。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，请立即以电子邮件通知发件人并删除本邮件及其附件。
> 
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!

Deleted.

If you want me to read your mail, you'll have to get rid of that footer.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
