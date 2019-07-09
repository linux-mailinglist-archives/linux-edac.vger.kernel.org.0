Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4A635E8
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGIMbH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 08:31:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfGIMbG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 08:31:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33CBD1F65E6AF96065CC;
        Tue,  9 Jul 2019 20:31:02 +0800 (CST)
Received: from localhost (10.45.141.82) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 20:31:01 +0800
Date:   Tue, 9 Jul 2019 13:30:56 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <paulmck@linux.ibm.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
Message-ID: <20190709133056.00001c57@huawei.com>
In-Reply-To: <45e9ac35-9ffc-8f5f-cbdb-f85453227363@amazon.com>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
        <1562500658-14717-3-git-send-email-hhhawa@amazon.com>
        <20190709173229.0000135f@huawei.com>
        <45e9ac35-9ffc-8f5f-cbdb-f85453227363@amazon.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.141.82]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 9 Jul 2019 14:01:03 +0300
"Hawa, Hanna" <hhhawa@amazon.com> wrote:

> On 7/9/2019 12:32 PM, Jonathan Cameron wrote:
> >> Signed-off-by: Hanna Hawa<hhhawa@amazon.com>  
> > A quick drive by review as I was feeling curious.
> > 
> > Just a couple of trivial queries and observation on the fact it
> > might be useful to add a few devm managed functions to cut down
> > on edac driver boilerplate.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> +#define ARM_CA57_CPUMERRSR_VALID		GENMASK(31, 31)  
> > For a single bit it's common to use BIT(31) rather than GENMASK to make
> > it explicit.  
> 
> Will fix.
> 
> > 
> >   
> >> +	edac_dev->mod_name = dev_name(dev);  
> > I'd admit I'm not that familiar with edac, but seems odd that a
> > module name field would have the dev_name.  
> 
> Will fix when I got more inputs.
> 
> >   
> >> +	edac_device_free_ctl_info(edac_dev);  
> > More a passing observation than a suggestion for this driver, but if there was
> > ever a place where it looked like a couple of devm_ allocation functions would
> > be useful, this is it;)
> > 
> > edac_dev = devm_device_alloc_ctrl_info(dev, ...)
> > ...
> > devm_edac_device_add_device(dev, ...)  
> 
> I agree.
> I can implement the devm_* functions in separate patches as this is not 
> related to my patches (and not to delay this patches).
> 

Great.

Jonathan

> > 
> >   


