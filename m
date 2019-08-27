Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617549E1F0
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfH0Hxm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 03:53:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfH0Hxl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 03:53:41 -0400
Received: from zn.tnic (p200300EC2F0CD000E4ECF72BFDD79A39.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:e4ec:f72b:fdd7:9a39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 567081EC0965;
        Tue, 27 Aug 2019 09:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566892420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8p1J/zPTLAzb8JP6Pzlpwjulw1RiTNpv98AQ/qRNp1A=;
        b=Ek/6sU/qfsfjFwI81AIhXWbsw/CibP44YJzq3iiM1ULP96lzq9ngzBvVpHQTgKxXWya37u
        +RE51/ByIrjJHM/272sv7weTWlIICuu1CW6Nt1QnXcH9T3BwNNTMAwROMtzbS7e4mEuEjz
        xv0kJO1hEwG0Dod9hcyOj4NN1XV6GmQ=
Date:   Tue, 27 Aug 2019 09:53:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190827075336.GB29752@zn.tnic>
References: <BN6PR04MB1107CE3C2D666A806E62851B86C10@BN6PR04MB1107.namprd04.prod.outlook.com>
 <20190807144016.GA24328@zn.tnic>
 <BY5PR04MB659914AC91EBB3EAF72977BD86D20@BY5PR04MB6599.namprd04.prod.outlook.com>
 <20190819093147.GE4841@zn.tnic>
 <BY5PR04MB65996BD47D541327F8F1BE4A86A00@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB65996BD47D541327F8F1BE4A86A00@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 27, 2019 at 01:49:29AM +0000, Lei Wang wrote:
> Yes, this is to help open source developers who potentially might want 
> to expand this driver, most likely colleagues, and possibly other 
> developers.

Then please put that info in the comment at the beginning of the driver
- not some random single sentences about what can be done, interspersed
throughout the code. It needs to be visible at a first glance.

Also, if you want this to be a longer doc, I wouldn't mind at all having
it in Documentation/edac/ (which doesn't exist yet) and then point
people to it from the comment at the beginning of the driver.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
