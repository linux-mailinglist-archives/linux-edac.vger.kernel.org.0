Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCBD7182
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfJOIso (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 04:48:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfJOIso (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Oct 2019 04:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PZs2Jew1Apcdf2AL00ZC9tQ/+7iCmPCjp3H58ifi9kY=; b=hdwt12/0qG3iaS8UDIeaV6OeT
        tFWgC5uur0rZhU5DuiIm1RCpWVqBjORlw4dLTzGtKm3n9dWhM48M9oQtbksvQoPa3gihlBl3dnsG8
        BR8lVZ3SpR4xBhp/F+x+EAxPEnenm89BkltBeLWzPnbL+FtgOKCj5AOgn5ZEVQYCAWFy9y69O58Vk
        EMLzBLvIq7hS5X3kLFKcFqJF6u4JJMdj/W/++YE51InAPEdltcgY5S9qYGquoGugiYDNEVk3iVEuE
        K1GXMLtYoJluJU8UhTQcUwLGQMtOSmfqOTYUAc+7bgm5hM4/6BHQXpQ5la89gYMfjmNCSuRlV6t3/
        SfMUNJt3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKIVP-0003za-My; Tue, 15 Oct 2019 08:48:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE17A304637;
        Tue, 15 Oct 2019 10:47:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36F94284DE590; Tue, 15 Oct 2019 10:48:33 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191015084833.GD2311@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 02:21:00PM -0700, Srinivas Pandruvada wrote:
> Some modern systems have very tight thermal tolerances. Because of this
> they may cross thermal thresholds when running normal workloads (even
> during boot). The CPU hardware will react by limiting power/frequency
> and using duty cycles to bring the temperature back into normal range.
> 
> Thus users may see a "critical" message about the "temperature above
> threshold" which is soon followed by "temperature/speed normal". These
> messages are rate limited, but still may repeat every few minutes.
> 
> The solution here is to set a timeout when the temperature first exceeds
> the threshold.

Why can we even reach critical thresholds when the fans are working? I
always thought it was BAD to ever reach the critical temps and have the
hardware throttle.


