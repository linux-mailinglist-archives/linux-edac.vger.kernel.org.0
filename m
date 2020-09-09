Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41C26375B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIUbJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Sep 2020 16:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIUbF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Sep 2020 16:31:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2245C061573
        for <linux-edac@vger.kernel.org>; Wed,  9 Sep 2020 13:31:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so1926989pjb.2
        for <linux-edac@vger.kernel.org>; Wed, 09 Sep 2020 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8+h8nOrddZ60rlqGY9p7zSWVef5h+u0J2bJfQopxnyQ=;
        b=MiqgAN2OnenhsyDpyowqhXqf6C6CRJ6jVfkqQesa+MBeanQoilnFquVDff+DJUzapj
         km6Fowe25oRZ+qYHDZ/VAt5qim0j3EzThGbAvQLyq1faD5fUYevP5KAv+B92wZwakyHy
         Zmx9m+FV4gP+7WUYXWgW/vj+TXgnADnqytLUWTVwZDzpeQ56e5VOKivWCizhVSxJatFE
         QvFmSFuSVVV1Z5wkPBoljWJHLfw1eAy2OH3dsz4qGlgnF1QCCuH9nWMWpMHNQs1Zq9OD
         N9TuKc5tCYspc2dDK//nNIWJ8mfrH+k4RDSeYINS2IBNOO3QMf0rqUj7mBDbZygGWI30
         FwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8+h8nOrddZ60rlqGY9p7zSWVef5h+u0J2bJfQopxnyQ=;
        b=WbiQJigN7X9dOa57RlaOCOawRV2D7Jbu1IelUeYz3qzw6URNcOjnxjOY6JLUyIinRX
         vZWsc9HDt+pAmaTt8NW2Y9hZKYN90VodNxBAL3vGZbUfgzTCLefRxNRtJkXm5suRX2vI
         2Wq10XCOHY/sK+/qGg99fR5FNUuzHyYWfs++Ajz+5l0Zo1wm0P0tcy53Q6cmmC74qwV+
         ykvelhEccsw57OfDWkHoriItfKL2zDpW2kc+FfDM8Gp+/fBCFxZnmP/lw2NOzOhgK4eB
         nRhWQxyCMPM7xmENVwqrhwpUj3LO0mgzFJHrJL41oifx5K16QZs/LhJGBWBwUK6ADdcC
         2aSQ==
X-Gm-Message-State: AOAM5337kj8DN4S4iRDpbCj+vGYePEFWQwAhfp89q2/d3/6V9+hiSNs9
        3JhAoWQHXhYP65KKPqTz2sojZw==
X-Google-Smtp-Source: ABdhPJxe3euwzyJoC/f5HEii0QnaurgSe+quMpchKvFdeV9Etihcx+hbO9sMKi7a+vuksp+62X0OeA==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id t15mr2308869pjm.19.1599683462094;
        Wed, 09 Sep 2020 13:31:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 31sm2962434pgs.59.2020.09.09.13.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:31:01 -0700 (PDT)
Date:   Wed, 09 Sep 2020 13:31:01 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Sep 2020 13:30:24 PDT (-0700)
Subject:     Re: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR controller driver
In-Reply-To: <20200909060045.GA13647@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>, dkangude@cadence.com,
        yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        rrichter@marvell.com, james.morse@arm.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-1b96da02-cbf5-42f4-bc30-a1c5c9cce5fa@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 08 Sep 2020 23:00:45 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 08:12:16PM -0700, Palmer Dabbelt wrote:
>> I don't know enough about the block to know if the subtle difference in
>> register names/offsets means.  They look properly jumbled up (ie, not just an
>> offset), so maybe there's just different versions or that's the SiFive-specific
>> part I had bouncing around my head?  Either way, it seems like one driver with
>> some simple configuration could handle both of these -- either sticking the
>> offsets in the DT (if they're going to be different everywhere) or by coming up
>> with some version sort of thing (if there's a handful of these).
>
> regmap can be used to handle non-uniform register layouts for the same
> functionality.

Ah, cool, I hadn't seen that before.  That seems like the way to go if this is
truly an implementatic-specific register mapping.  As I was falling asleep last
night I remembered that we did end up with implementation-specific register
maps for some of the IP we integrated.  That was usually the case for IP where
we had some signals that we just didn't know what to do with, and while I know
the DDR integration was a real trip I'm not sure if that's where these
registers came from.

Hopefully someone who has better access to these hardware implementations can
comment.
