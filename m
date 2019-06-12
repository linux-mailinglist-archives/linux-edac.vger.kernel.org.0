Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82C742336
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfFLLAr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 07:00:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55604 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbfFLLAr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 07:00:47 -0400
Received: from zn.tnic (p200300EC2F0A6800D18ACEC6DD65F264.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:d18a:cec6:dd65:f264])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FE0B1EC09C0;
        Wed, 12 Jun 2019 13:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560337245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HOMK+9JvCIpMQ3+nyUvjKfhBVhvirtCjErehwrT4UyU=;
        b=k8v11BX5NOmU7kAzEv7EF+RwnANERInaAO4pBImSmW8ZH30tz0tPIlOMF/V2qcf1d206Ho
        FiTPJGZjo0cfVOcgOQkrAh8BgtBHFIDIJTwXWA+jF78Nyvk+xds4kwQklnkexcjtw9q2nB
        j0XAmObOKvCgPABYwk14zIXNjbc0Iqk=
Date:   Wed, 12 Jun 2019 13:00:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
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
Message-ID: <20190612110039.GH32652@zn.tnic>
References: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
 <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
 <20190608090556.GA32464@zn.tnic>
 <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
 <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
 <20190611115651.GD31772@zn.tnic>
 <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
 <20190612034813.GA32652@zn.tnic>
 <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
 <20190612074242.53a4cf56@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612074242.53a4cf56@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 12, 2019 at 07:42:42AM -0300, Mauro Carvalho Chehab wrote:
> That's said, from the admin PoV, it makes sense to have a single
> daemon that collect errors from all error sources and take the
> needed actions.

Doing recovery actions in userspace is too flaky. Daemon can get killed
at any point in time and there are error types where you want to do
recovery *before* you return to userspace.

Yes, we do have different error reporting facilities but I still think
that concentrating all the error information needed in order to do
proper recovery action is the better approach here. And make that part
of the kernel so that it is robust. Userspace can still configure it and
so on.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
