Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09544D6B4C
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfJNVg2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 17:36:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbfJNVg2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 17:36:28 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 151951EC0C8E;
        Mon, 14 Oct 2019 23:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571088987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kNhe2TlSQJMPOaQ79SSPMH5z8CjruZRN7lsslQeR9v0=;
        b=qlk6q3ZGBCFUJ3QdCxqIp35pdSKnkmMIS8hIIwHstgjAw/lsgw0T8tPl6ToLftvpiFL+sQ
        C5IKqg+PB0ERoPcSGNqmspiyC71MTjiFzo/F/OX2kXYdHQ8c/x7q2w63WrrfDsyaoLdnV+
        JjMJQ3iZKbvKJjeYwG8jp4yH12v1VLs=
Date:   Mon, 14 Oct 2019 23:36:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191014213618.GK4715@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> the threshold. If the CPU returns to normal before the timeout fires,
> we skip printing any messages. If we reach the timeout, then there may be
> a real thermal issue (e.g. inoperative or blocked fan) and we print the
> message (together with a count of how many thermal events have occurred).
> A rate control method is used to avoid printing repeatedly on these broken
> systems.
> 
> Some experimentation with fans enabled showed that temperature returned
> to normal on a laptop in ~4 seconds. With fans disabled it took over 10
> seconds. Default timeout is thus set to 8 seconds, but may be changed
> with kernel boot parameter: "x86_therm_warn_delay". This default interval
> is twice of typical sampling interval for cooling using running average
> power limit from user space thermal control softwares.
> 
> In addition a new sysfs attribute is added to show what is the maximum
> amount of time in miili-seconds the system was in throttled state. This
> will allow to change x86_therm_warn_delay, if required.

This description is already *begging* for this delay value to be
automatically set by the kernel. Putting yet another knob in front of
the user who doesn't have a clue most of the time shows one more time
that we haven't done our job properly by asking her to know what we
already do.

IOW, a simple history feedback mechanism which sets the timeout based on
the last couple of values is much smarter. The thing would have a max
value, of course, which, when exceeded should mean an anomaly, etc, but
almost anything else is better than merely asking the user to make an
educated guess.

> Suggested-by: Alan Cox <alan@linux.intel.com>
> Commit-comment-by: Tony Luck <tony.luck@intel.com>
  ^^^^^^^^^^^^^^^^^^

What's that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
