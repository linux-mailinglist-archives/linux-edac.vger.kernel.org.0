Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCEE1CDD19
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgEKO00 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKO00 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 May 2020 10:26:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5824C061A0C
        for <linux-edac@vger.kernel.org>; Mon, 11 May 2020 07:26:25 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F10085E3BAC78343E356.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f100:85e3:bac7:8343:e356])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 674E41EC0136;
        Mon, 11 May 2020 16:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589207184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c6CoI4K9gQczpQm+r/wqtnDiODAth8WxEIRuNQ6Z2qs=;
        b=feX+2tihT6LqAkznTaDdWYAFcBXkZ6a7eovyhw6u0SmI719EeScFkTHltAjc0GTPSmnDyQ
        3JmRkC8jcfiMWqVw7/5XCoXiD9+eZkXe0SO7blusngmAlY/iNW/1lux7DHiZKIBjvHZFow
        CWNJ52rKieZ1dN9UcIHTdziBNMZAfKE=
Date:   Mon, 11 May 2020 16:26:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, talel@amazon.com,
        jonnyc@amazon.com, "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [RFC] Support different block names with same EDAC device
Message-ID: <20200511142619.GD25861@zn.tnic>
References: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
 <20200511135507.GC25861@zn.tnic>
 <2fc308f9-47d6-7c75-775b-3f6579dfe571@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fc308f9-47d6-7c75-775b-3f6579dfe571@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 11, 2020 at 05:21:14PM +0300, Hawa, Hanna wrote:
> I'm trying to create different block names e.g. hw_block_a, hw_block_b.

Please give an actual example of the names you're trying to add and how
the hierarchy you think should look like.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
