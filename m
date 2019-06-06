Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9594D37134
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfFFKDU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 06:03:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfFFKDU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Jun 2019 06:03:20 -0400
Received: from zn.tnic (p200300EC2F1EFA00C5555FEB083E0D5D.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:c555:5feb:83e:d5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F008C1EC02FE;
        Thu,  6 Jun 2019 12:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559815398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gY7wo5tn+Q6xuDLRFIE/jPyAZiFytadxsFIYa94a7Xg=;
        b=cAtCEzCXTH50n+mSHu26/2RPN9U0/FM0abQbzcs68cQvcwFuwUoHCIoUi4NOe00kr5G8oW
        af88+35wfOFlo9OMy23Rug6cKERrEBIeHoi/zS7TZGj2Wwuux0p/EROmUW9QX8eJhjc5Mx
        w7Yjwi4RLHRtXbEUyf+htu9TVGIX+CI=
Date:   Thu, 6 Jun 2019 12:03:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
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
Message-ID: <20190606100312.GD26146@zn.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 06, 2019 at 10:53:42AM +0300, Hawa, Hanna wrote:
> Disagree. The various drivers don't depend on each other.
> I think we should keep the drivers separated as they are distinct and
> independent IP blocks.

This topic comes up each time someone submits a new ARM EDAC driver:
EDAC can't support different drivers because of the limitations it has.
And a single platform driver works - see altera_edac.

Again, James has a good write up with example how this can work so be
patient.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
