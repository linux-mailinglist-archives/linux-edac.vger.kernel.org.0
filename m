Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC842D0FC6
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLGLyu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 06:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgLGLyu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Dec 2020 06:54:50 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3913C0613D2;
        Mon,  7 Dec 2020 03:54:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z11so2988733qkj.7;
        Mon, 07 Dec 2020 03:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E49RW3lCYWJrRHYIOf8r6xoeeHtbQpoKE5fOTw71iZo=;
        b=SC5cS/hNjMqFSJGp92Czw/Dl4zANswBGyHPMn5sBorqcFfd0xp1WUId65rkdpnvgLJ
         UDGS4ehZm7nOxE18JRAjnm9uEFr6RdW0SDIcLWxdOcXs74MieegRUh14FNN0eumwNwv3
         hwNslglXh0I/5vN4zRprw8EjNoLnjYVS1/vP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E49RW3lCYWJrRHYIOf8r6xoeeHtbQpoKE5fOTw71iZo=;
        b=th53Yj5MGSWSUwpLBo8/aZLgN2wVRFMqYZXGndFaISNuP7GECtP4//r7EJ/6e0Dbsz
         n/+NOQga6jxsaqbmRxBhtv3/7phORrvn8dZNKHFTLO40OjnQlT3OQGVY5HM8KfoZLmFl
         298n81f77hGr0rUKgMQMc+d92K6lSPR+XMTqX6CZx1M+jV5BKTi61o1agGptiSVnL2uA
         d5kqfWZygD5zbLGXp9UXRq7Ptfz0zMFoNL6A3QZh4qFPWSjBFg2FlYzqVL47DnFBdSq/
         sQiqfWYFyAG5oxrrqCdTpGiY2y8STN2wg1A8lTKXTBW5tv8VdsjsozT5F8EafRKfkM40
         7VOQ==
X-Gm-Message-State: AOAM530LcuUdDkZRgPXDyvbKInU17IdtwBmND6hGrywAnhvii+Rmb8S1
        DrmUA+t7efNtqEwhHEQwM8R4I3sVaNXvojTfzg4=
X-Google-Smtp-Source: ABdhPJwMVIarKWFTAT6CPBVIaqd6FKPGstN2lTEsLyCRkC4SMh9VXx5/1AbJYFRigDi1UcqIgH0/ixKSkql6qwp0Tho=
X-Received: by 2002:a05:620a:2101:: with SMTP id l1mr3530842qkl.55.1607342043919;
 Mon, 07 Dec 2020 03:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20201207090013.14145-1-troy_lee@aspeedtech.com> <20201207090013.14145-3-troy_lee@aspeedtech.com>
In-Reply-To: <20201207090013.14145-3-troy_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 7 Dec 2020 11:53:51 +0000
Message-ID: <CACPK8Xdo1Ove0Gysd6g6ke9rk2QED4kCjxKEAdSV9SbbFkViVg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] edac: Supporting AST2400 and AST2600 edac driver
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        leetroy@gmail.com, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 7 Dec 2020 at 09:01, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Adding AST2400 and AST2600 edac driver support.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
