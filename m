Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD47DF36E
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 18:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfJUQoE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 12:44:04 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58092 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfJUQoD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 12:44:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 859F1175D;
        Mon, 21 Oct 2019 09:43:47 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0929D3F71F;
        Mon, 21 Oct 2019 09:43:43 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <1ae9a840-d5b6-ccd6-8481-d43665b4411b@arm.com>
Date:   Mon, 21 Oct 2019 17:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB65996A0CEB37001C763B248C866C0@BY5PR04MB6599.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

On 18/10/2019 21:08, Lei Wang wrote:
> This thread hasn't got traction from DT owners.

It looks like your patches didn't make it to the mailing list:
https://lore.kernel.org/r/BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com

You can search on https://lore.kernel.org/linux-edac/, I can only see the replies from the
people who received it directly.

I can't see anything obvious in the headers that would cause it to get rejected. Did you
get any bounces/errors from the list?

Depending on how the DT folk work, this may be why you haven't had a response yet. Tools
like patchwork will depend on the message reaching the list.


> James did give ACK before.
> Should that be good enough?

Nope! You need someone from the maintainer's entry for those files to review it.
I gave my R-B as what you'd done made sense from the TRM and the driver. The DT folk will
have a wider view and may have some advice.


Thanks,

James
