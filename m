Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DCB4A0127
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiA1Txh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 14:53:37 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:36158 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiA1Txg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Jan 2022 14:53:36 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 1B7E92099E9D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
To:     Borislav Petkov <bp@alien8.de>
CC:     Dinh Nguyen <dinguyen@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
 <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org> <YfQ3xUpLOPvDu5W+@zn.tnic>
 <ba83ca78-6a15-caf5-71ba-76d5b2b1b41d@omp.ru>
 <9f28d2de-5119-a7a6-9da7-08b2ce13f1a0@omp.ru> <YfRBCPRPkf+gD18/@zn.tnic>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <475867ea-eb32-0106-728b-ec4cd2f99c55@omp.ru>
Date:   Fri, 28 Jan 2022 22:53:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YfRBCPRPkf+gD18/@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/28/22 10:16 PM, Borislav Petkov wrote:

[...]

>> Ah, you were wondering about returing -EPROBE_DEFER? It started to be returned
>> by the commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef several months before that...
> 
> More precisely, I'm wondering after which commit does the deferred
> probing code interpret -EPROBE_DEFER properly so that a backport of this
> commit would be even worth the trouble?

   That was even longer ago, done by the commit d1c3414c2a9d10ef7f0f7665f5d2947cd088c093
in 20212, if you must know. :-)

> Because if we backport it to kernel where there's not even deferred
> probing support, then that backport is a waste of time.

   I think you're overly caustious in this case. :-)

MBR, Sergey
