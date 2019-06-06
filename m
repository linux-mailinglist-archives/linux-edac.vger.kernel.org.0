Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088DC372AD
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFFLWY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 07:22:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFFLWY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Jun 2019 07:22:24 -0400
Received: from zn.tnic (p200300EC2F1EFA0069BEA28104A317EB.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:69be:a281:4a3:17eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 344051EC01AD;
        Thu,  6 Jun 2019 13:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559820142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xc7XgRaBZPknCjJo1rIDVERLBN/P7FUkAHIt/67cwZw=;
        b=dm+id48iBC88mNIVr2UxAiHkVQoyU+ZubYsESCOUC42epYrUjvcoHuhR7CAqPiMchtbt3t
        3irUUxE2mTfYXQKRDkv+dGJxKNZ/FTePLWhpk4gBZLBgbqCas5Z6ix9N+/at7UYvQDHrzm
        eG56JegYO97ImsfAvwWA31sAlo+E/Kk=
Date:   Thu, 6 Jun 2019 13:22:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
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
Message-ID: <20190606112217.GE26146@zn.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
 <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 06, 2019 at 11:33:30AM +0100, James Morse wrote:
> All these are integration choices between the two IP blocks, done as separate drivers we
> don't have anywhere to store that information. Even if you don't care about this, making
> them separate drivers should only be done to make them usable on other platforms,

... that we can do with a separately integratable object like
fsl_ddr_edac.c does it, for example, where it is shared between
two different platform drivers.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
