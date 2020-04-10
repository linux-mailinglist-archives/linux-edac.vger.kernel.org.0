Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F31A4377
	for <lists+linux-edac@lfdr.de>; Fri, 10 Apr 2020 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgDJIXv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Apr 2020 04:23:51 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:52378 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDJIXv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Apr 2020 04:23:51 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e902d07bec-00d91; Fri, 10 Apr 2020 16:23:36 +0800 (CST)
X-RM-TRANSID: 2eeb5e902d07bec-00d91
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e902d07967-23973;
        Fri, 10 Apr 2020 16:23:36 +0800 (CST)
X-RM-TRANSID: 2ee25e902d07967-23973
Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
To:     Borislav Petkov <bp@alien8.de>, rrichter <rrichter@marvell.com>
Cc:     "thor.thayer" <thor.thayer@linux.intel.com>,
        mchehab <mchehab@kernel.org>, "tony.luck" <tony.luck@intel.com>,
        "james.morse" <james.morse@arm.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
 <20200402123001.obgzqmlure4cfvh7@rric.localdomain>
 <202004022106312118022@cmss.chinamobile.com>
 <20200408071022.ft6aamptrxlaz23f@rric.localdomain>
 <2020040819334451781313@cmss.chinamobile.com>
 <20200408113658.GE24663@zn.tnic>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <1b9a872f-f616-8eaf-1cca-d73647f696e3@cmss.chinamobile.com>
Date:   Fri, 10 Apr 2020 16:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200408113658.GE24663@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav & Robert:

On 2020/4/8 19:36, Borislav Petkov wrote:
> On Wed, Apr 08, 2020 at 07:33:44PM +0800, Tang Bin wrote:
>>    I know what you mean, Thanks.
> I don't think you do because you still top-post.
>
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top

I am sorry for the previous writing mistake(top-post). I have consulted 
others and hope it's right this time. Sorry again and thanks for 
teaching. I hope to continuously improve myself and regulate myself 
under your guidance.

Thanks.

Tang Bin



