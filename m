Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC32DC45B
	for <lists+linux-edac@lfdr.de>; Wed, 16 Dec 2020 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLPQfO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Dec 2020 11:35:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgLPQfN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Dec 2020 11:35:13 -0500
Received: from zn.tnic (p200300ec2f10c100782932abc779af15.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:c100:7829:32ab:c779:af15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DEAE1EC054C;
        Wed, 16 Dec 2020 17:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608136472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MJqZ0EEfxNAt7+1da2yoYx3MeKH3Sm37n+sKmTXcCd0=;
        b=YepjN+b0N5kk5OJ6i7oVRYIK57Wd+3hwKqkEbb0qH1+QQQ6TaGXuECpZsXGv1q3bH53pFx
        dmtDialxLeN7dI81C9Biqfq1uwjgcE3uOMmVXmLL3ou6w3E5z0L8BhIXSssCZ9CzBLEj01
        +Ylq1Ep5bfNsd6UbHZ1IM0HA+7OsRwo=
Date:   Wed, 16 Dec 2020 17:34:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Di Domenico <mdidomenico4@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: dimm mapping
Message-ID: <20201216163427.GA6312@zn.tnic>
References: <CABOsP2O+42Kcf7F5mkzkSizTKGSG48giwkgiv3gN=KZZ+Ad+4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABOsP2O+42Kcf7F5mkzkSizTKGSG48giwkgiv3gN=KZZ+Ad+4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 16, 2020 at 10:06:21AM -0500, Michael Di Domenico wrote:
> is there some tool that merges the 'dmidecode -t memory' output with
> 'edac-util -v' to give me the mapping of my motherboard for the
> labels.db file?
> 
> the only documentation i've been able to find on the net, says to
> populate one dimm at a time and write down the mapping, which seems
> horribly dated for 2020

There's a whole subsystem - EDAC - trying to do that mapping between
silkscreen labels on the motherboard and actual DIMMs and there are
cases where that is simply impossible. Unfortunately.

What is the problem you're trying to solve?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
