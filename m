Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9EA6487
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICI61 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 04:58:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfICI61 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Sep 2019 04:58:27 -0400
Received: from zn.tnic (p200300EC2F0CBF0008E9AF92B14A1F7E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:bf00:8e9:af92:b14a:1f7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0AA91EC0428;
        Tue,  3 Sep 2019 10:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567501101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3CsF8bhDZKwgwLASVgI+cCHhHJIZXtwmCXB+oV5r6YQ=;
        b=qpGoVUUt9clSlVfR0Y7O5cZ1/F6vWs+eCyIDwVFZ6+jzADjKZFvLKACCb3hsF/z5s3zjVT
        ZBODLIY6C75WJYKRt60jrAZhrJfHQqJWzjLZw3HB0hNyk7Jdv4wV3gMKKjwF9uSfw0Ruwt
        0pat1qASCK6Qwp3KmFfW+gPVvKHHzsg=
Date:   Tue, 3 Sep 2019 10:58:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Message-ID: <20190903085816.GA11641@zn.tnic>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
 <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
 <2bce020a-bf7e-1d54-48c3-0aa6d23c84d8@amazon.com>
 <20190903084614.mthff6hzbchkw7t2@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903084614.mthff6hzbchkw7t2@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 03, 2019 at 08:46:24AM +0000, Robert Richter wrote:
> This is good, but recent practice is also to have all the drivers for
> the same piece of hardware in a single file, see e.g. thunderx_edac.c.
> I don't know how detailed this was discussed already, but I would
> prefer to join the code.

This is no longer needed anymore. Check out this thread:

https://lkml.kernel.org/r/1559211329-13098-3-git-send-email-hhhawa@amazon.com

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
