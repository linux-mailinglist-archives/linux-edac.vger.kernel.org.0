Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD942AFA
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409381AbfFLPee (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 11:34:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbfFLPee (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 11:34:34 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1E021EC09C0;
        Wed, 12 Jun 2019 17:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560353672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g4rWJFjEM7kkULl6vDi+aUBsBu1usG9lRov9A1JP3uU=;
        b=lBOJAcIAePCGsIZyQbFRsd5z9TmBH7Q317mtuTr7HkJkA5n4O3qoOw2ntlUcsXLt52JzVc
        k7bRn3onzr+vJNStvcQU+K76Q8NFGuywblnA7GCANZ0xZHDnkIC+mnCgcM0CQTB0Rd9r8h
        lPG2PWO9qMhn7X6ndpemHttD9mBP1V8=
Date:   Wed, 12 Jun 2019 17:34:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190612153425.GL32652@zn.tnic>
References: <20190611115651.GD31772@zn.tnic>
 <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
 <20190612034813.GA32652@zn.tnic>
 <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
 <20190612074242.53a4cf56@coco.lan>
 <20190612110039.GH32652@zn.tnic>
 <20190612084213.4fb9e054@coco.lan>
 <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
 <20190612122504.GI32652@zn.tnic>
 <6911a79a-bcd7-03e1-1c90-2adb88aaa1db@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6911a79a-bcd7-03e1-1c90-2adb88aaa1db@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 12, 2019 at 03:35:31PM +0300, Hawa, Hanna wrote:
> We have daemon script that collects correctable/uncorrectable errors from
> EDAC sysfs and reports to Amazon service that allow us to take action on
> specific error thresholds.

What does "take action" mean, more specifically? Is the script taking
action to poison/isolate memory or a guy goes down to the basement and
replaces parts? :-)

IOW, I'm interested in whether you guys need an additional recovery
action agent and if so, whether it would make sense to have something
generic in the tree, which can be shared with others...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
