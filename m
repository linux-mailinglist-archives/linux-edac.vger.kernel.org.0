Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73066E1C55
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405771AbfJWNWj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 09:22:39 -0400
Received: from [217.140.110.172] ([217.140.110.172]:52010 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2405770AbfJWNWj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 09:22:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DFE4A7;
        Wed, 23 Oct 2019 06:22:19 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB1B3F6C4;
        Wed, 23 Oct 2019 06:22:13 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <20190923161015.GI15355@zn.tnic>
 <e2b9cd68-abaa-bdcd-cc56-cca285272569@outlook.com>
 <41637032-a308-9a92-1b49-cb51af2580f8@outlook.com>
 <BY5PR04MB65996A0CEB37001C763B248C866C0@BY5PR04MB6599.namprd04.prod.outlook.com>
 <1ae9a840-d5b6-ccd6-8481-d43665b4411b@arm.com>
 <BY5PR04MB659953E22E846D0BF4384D0086690@BY5PR04MB6599.namprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <70e31777-f4c0-fdd2-fcae-6589d355dd28@arm.com>
Date:   Wed, 23 Oct 2019 14:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB659953E22E846D0BF4384D0086690@BY5PR04MB6599.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

On 21/10/2019 18:36, Lei Wang wrote:
>> It looks like your patches didn't make it to the mailing list:
>> https://lore.kernel.org/r/BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com
>>
>> You can search on https://lore.kernel.org/linux-edac/, I can only see the replies from the
>> people who received it directly.
>>
>> I can't see anything obvious in the headers that would cause it to get rejected. Did you
>> get any bounces/errors from the list?
>>
>> Depending on how the DT folk work, this may be why you haven't had a response yet. Tools
>> like patchwork will depend on the message reaching the list.
> 
> Yes I got reject from
> 
> linux-edac@vger.kernel.org

> devicetree@vger.kernel.org

This is very likely the reason the DT folk haven't seen this.


> with the reason of
> 
> vger.kernel.org gave this error:
> Hello [40.92.9.51], for your MAIL FROM address <leiwang_git@outlook.com> 
> policy analysis reported: Your address is not liked source for email
> 
> I'll resend from another email address that hopefully the email list 
> likes. Is there some guideline on what email addresses are liked and not 
> liked?

There doesn't seem to be a list, I guess subscribe and see if it works.
(You should subscribe to a list before posting to it. It avoids issues like this)

outlook.com is mentioned here:
http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-January/018562.html

and a few more details on yahoo and AOL here:
https://kernelnewbies.kernelnewbies.narkive.com/F9mlJOst/why-the-email-of-yahoo-com-can-t-subscribe-majordomo-vger-kernel-org

Petition your employer for a working email setup?
(or use gmail...)


Thanks,

James
