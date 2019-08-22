Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB098DD6
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfHVIf5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Aug 2019 04:35:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbfHVIfx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 04:35:53 -0400
Received: from zn.tnic (p200300EC2F0DB40065DA7FD15FC076CF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b400:65da:7fd1:5fc0:76cf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F4E51EC09E2;
        Thu, 22 Aug 2019 10:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566462952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tZsBpBeuzxJNAMOoY3isuwAxZ1gaYseBc/x0GS8Xz8M=;
        b=Lc3RqVGONQFsGtZpOxtlF4GTHTKFz028Au1iyZ/qu+JNmTDfFKvTpyYp6ttgZXOsRs0JOL
        2Xi5IYTgi1dlDCMTzO7VwdWPlOEQ6hd65KkLIZs0w8mBHA5Zl2ychDwEhr/GCNQ7wnahqH
        t+eaEy0AvUPIUczgCp0mRXERXK2dGSM=
Date:   Thu, 22 Aug 2019 10:35:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190822083548.GA11646@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822005020.GA403@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 02:50:20AM +0200, Adam Borowski wrote:
> While you're editing that code, could you please also cut the spam if ECC is
> actually disabled?  For example, a 2990WX with non-ECC RAM gets 1024 lines;

Patch is in there. I'll give you extra points if you spot it.

> Meow!

Wuff!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
