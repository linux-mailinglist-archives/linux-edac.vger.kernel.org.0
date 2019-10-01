Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90D3C2EE7
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbfJAIcq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 04:32:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfJAIcq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Oct 2019 04:32:46 -0400
Received: from zn.tnic (p200300EC2F0A2D0084604B8D68D34A5E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:8460:4b8d:68d3:4a5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 176B21EC03AD;
        Tue,  1 Oct 2019 10:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569918765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8omf2Ond+HjWgVnZgR3IZ7lalr9H6LO8bfe8Bs9TbPM=;
        b=VaEc2mCSAFRpSLy/fkc5shomJWzgGFT0ONazx9MCWEXokTZZBkJesR0DKxms8UL2wCDdmu
        M33jqaXvDf/2GvttfnHvaLlknCnhi4bwKKMDEOdkmJDvcpjY4F7hHehHfhyyxrTdv24Zjy
        YBOXQ7mIMQBGD2AGS5yg0UfvtvqV0Hs=
Date:   Tue, 1 Oct 2019 10:32:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Hanna Hawa <hhhawa@amazon.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Message-ID: <20191001083242.GA5390@zn.tnic>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com>
 <20190930145046.GH29694@zn.tnic>
 <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 01, 2019 at 06:56:58AM +0000, Robert Richter wrote:
> It is *not* the counterpart. The __* version already has the...

Lemme cut to the chase:

"Make the main workhorse the "count" functions which can log a @count
of errors. Have the current APIs edac_device_handle_{ce,ue}() call
the _count() variants and this way keep the exported symbols number
unchanged."

I want to see exactly *two* pairs of functions:

edac_device_handle_{ce,ue}_count	- logs a @count of errors
edac_device_handle_{ce,ue}		- logs a single error

Not three pairs. I.e., the "__" versions are not needed.

> The first patch only adds functionality but keeps the abi. Thus it
> makes a backport easier.

Works just the same with my version - single backport.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
