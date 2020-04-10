Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9A1A44FB
	for <lists+linux-edac@lfdr.de>; Fri, 10 Apr 2020 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDJKGf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Apr 2020 06:06:35 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:35837 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJKGf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Apr 2020 06:06:35 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e904511a46-04c7f; Fri, 10 Apr 2020 18:06:10 +0800 (CST)
X-RM-TRANSID: 2ee35e904511a46-04c7f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e904511e7f-1e29e;
        Fri, 10 Apr 2020 18:06:10 +0800 (CST)
X-RM-TRANSID: 2ee15e904511e7f-1e29e
Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
To:     Borislav Petkov <bp@alien8.de>
Cc:     rrichter <rrichter@marvell.com>,
        "thor.thayer" <thor.thayer@linux.intel.com>,
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
 <1b9a872f-f616-8eaf-1cca-d73647f696e3@cmss.chinamobile.com>
 <20200410095206.GA8205@zn.tnic>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <e9c88384-f807-4f9f-a3c1-d35675c3dd7d@cmss.chinamobile.com>
Date:   Fri, 10 Apr 2020 18:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410095206.GA8205@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav:

On 2020/4/10 17:52, Borislav Petkov wrote:
> On Fri, Apr 10, 2020 at 04:25:24PM +0800, Tang Bin wrote:
>> I am sorry for the previous writing mistake(top-post). I have consulted
>> others and hope it's right this time. Sorry again and thanks for teaching. I
>> hope to continuously improve myself and regulate myself under your guidance.
> That looks better, thanks!

Thanks for your patienct, thank you.

Tang Bin



