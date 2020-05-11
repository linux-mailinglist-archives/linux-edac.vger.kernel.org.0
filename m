Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6601CDC3A
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgEKNzR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730316AbgEKNzQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 May 2020 09:55:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70300C061A0C
        for <linux-edac@vger.kernel.org>; Mon, 11 May 2020 06:55:16 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F10085E3BAC78343E356.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f100:85e3:bac7:8343:e356])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57EC91EC031B;
        Mon, 11 May 2020 15:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589205312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2qyWyjkfg5PL3c/zl1zN8QlpUrK52KyMAjLNKt6X7Sg=;
        b=leKdjIe7wgxA4KghUSA2SVFc1vGevmBndDY4j2Ttfuw937nMIm5VU9+E2BSGOt9LA3Jatf
        KP+3AYdU8GUAVQW28p+MWqDDL2uVtG5rmke1hkaulCcsICXGA9J9WX7UcRYLHWUEGuoCNO
        aD+Tlbt98EGYhUlp+p550gTJ0LK1224=
Date:   Mon, 11 May 2020 15:55:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, talel@amazon.com,
        jonnyc@amazon.com, "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [RFC] Support different block names with same EDAC device
Message-ID: <20200511135507.GC25861@zn.tnic>
References: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 11, 2020 at 03:59:38PM +0300, Hawa, Hanna wrote:
> Can the edac device infrastructure support different block names? Shall we
> add support for such feature?

Does the "EDAC Blocks" section here:

Documentation/driver-api/edac.rst

answer your question?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
