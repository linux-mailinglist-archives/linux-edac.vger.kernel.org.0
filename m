Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14042251D18
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHYQVv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHYQVK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 12:21:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F6C061574
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:21:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so7734107pfp.7
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=L2oKOEupV27qICvhHWyDiF7Etr6coIqCr/1x6dmqhP8=;
        b=dUzGSIj7hwNgocfGDBX79TyuBWGD/fOm2Tg3Linokc59X0xu1MFMlmTbNgfGTy728H
         BdFE9PK3BVmeSzVuTlgnN53gSvnKvh9fS3mj7jGA2iZOsU1hhN4pIXHGs/JHtEk9cTmE
         FlEgt5s48sUOt/2X/olt0GRPSUg6ygVgvAiTmbiOEBpSP/a8sEbBASJ7otw07bfGV7gS
         MVA4xqoviXvU7lGMR6R587gy4jgLUBV9M8QV3Lj14ZGlZURKsqJtP0qdU88/Q4teVjUi
         Ie6nU3Zeq3C9ErwtB8wgQ5MxzDJQrcXiDyYuRHX76mNcCg+b2+icUn3keM2LOhjNxtQx
         yLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=L2oKOEupV27qICvhHWyDiF7Etr6coIqCr/1x6dmqhP8=;
        b=HKY+J2na2T9GLAGe3nTmetAJn7CH6noB6xyx3ftKV/aJHtmJYdjR2q+k3eTAxH9h22
         6NzDm+oV5bYACMta+tU2qO2xpSSRLikkwHfpbkNXX/Rzgy9l47uRcqmk8kw28q2kOuqw
         bHCGHiewconfIeesiZLlC5xZ2LsNqdKoxO/Wh+cdC6xzkpHqQgDO05D3I/ila83s2GYE
         j5tjt5oQhwpDNgiMS3vut2Lze+TZNBaAgwjNQ7T9SLNxKIjNIn34C0Klnffo/On9fxr+
         ToUYmqAg8Z8uXg6JUQtOUDcvHIpIiyYARQquNFU/x8Ut5CXqzQulCykBswlLRma7PlaF
         75Xg==
X-Gm-Message-State: AOAM530HhMq6SwOyB3BWaj1ot2znidqzp09U7SqW83dt78Ao/MJGMC5o
        CgjqdJTMkDQH/W/eOeqqL7Eo5g==
X-Google-Smtp-Source: ABdhPJwebpb1N/6mwKYVqcIkEX1j6oogLtgxeUyZeXL3dpd734Qx9PxxGJc0uVXs+W09T/PfruA5eg==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr8256384plb.23.1598372469704;
        Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d128sm15020864pfa.24.2020.08.25.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 09:21:08 PDT (-0700)
Subject:     Re: [PATCH 0/3] SiFive DDR controller and EDAC support
In-Reply-To: <20200825161958.GE12107@zn.tnic>
CC:     yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mchehab@kernel.org,
        tony.luck@intel.com, aou@eecs.berkeley.edu, james.morse@arm.com,
        rrichter@marvell.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bp@alien8.de
Message-ID: <mhng-a19106aa-1a18-4fe0-b8c1-9c765f03f73d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Aug 2020 09:19:58 PDT (-0700), bp@alien8.de wrote:
> On Tue, Aug 25, 2020 at 09:02:54AM -0700, Palmer Dabbelt wrote:
>> Thanks.  These look good to me and I'm happy to take them through the RISC-V
>> tree, but I'm going to wait for a bit to see if there are any comments from the
>> maintainers of the various subsystems before doing so.
>
> I'll have a look at the EDAC bits these days and give you an ACK if
> they're ok.

Thanks!
