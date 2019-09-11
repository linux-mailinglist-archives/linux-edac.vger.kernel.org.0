Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129D4AFEC8
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfIKOfs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 10:35:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37144 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfIKOfs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Sep 2019 10:35:48 -0400
Received: from zn.tnic (p200300EC2F0BA90014C938BBBD6B6EBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:a900:14c9:38bb:bd6b:6ebd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 351FA1EC026F;
        Wed, 11 Sep 2019 16:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568212542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5b3RygR2U6/KrPFM1rlXoIl2zeXVwwfaGF0dN616LbA=;
        b=Btj0bditSQZ1jaw8VNigNz0zPdxZ52+A8R3oC02y1ftIqy7e0JI/m8CppDAph2KeKuLHVf
        Muogd/1PrDLwFmvqILWhuEpkbFblR5jAs9T5/HK+S+qtIlVHqGv4KnJ60gZmQ3CjB/CUm3
        G2Zbb97fjVKO8eeuXo7fIyO9R+7/7d8=
Date:   Wed, 11 Sep 2019 16:35:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Subject: Re: [PATCH v3 1/4] x86/mce: Add Zhaoxin MCE support
Message-ID: <20190911143535.GA27910@zn.tnic>
References: <9d6769dca6394638a013ccad2c8f964c@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d6769dca6394638a013ccad2c8f964c@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 11, 2019 at 12:01:42PM +0000, Tony W Wang-oc wrote:
> All Zhaoxin newer CPUs support MCE that compatible with Intel's
> "Machine-Check Architecture", so add support for Zhaoxin MCE in
> mce/core.c.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
> v2->v3:
>  - Make ifelse-case to switch-case
>  - Simplify Zhaoxin CPU FMS checking

Btw, for future submissions - you don't have to do it now - search the
web for threaded mails, look at git-send-email's manpage and especially
the --thread and --chain-reply-to options. Also, look at lkml for
examples.

IOW, patchsets should have a 0/N message and all the others should
be sent as a reply to that message, i.e., shallow threading, as the
git-send-email manpage calls it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
