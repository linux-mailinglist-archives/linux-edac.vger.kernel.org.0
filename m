Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A7292F8B
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgJSUhg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Oct 2020 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgJSUhg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Oct 2020 16:37:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A2C0613CE
        for <linux-edac@vger.kernel.org>; Mon, 19 Oct 2020 13:37:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e23so781109wme.2
        for <linux-edac@vger.kernel.org>; Mon, 19 Oct 2020 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M2qNqlVTKQ2zqp8ZwSM77fodaDgRsv8br2tBLgwRw5Y=;
        b=FxBC3COAEqFUHT+Zn4+dO84MNeynoYkXs0Pa7nOnjNKB4blh7Ft3gtAtyw6HZ9ttfM
         Q5cTkJynsp0GAf2W//zB/T6c5dw6KCMqkedXXqjjooOOzUulSuUlOLNBJWVa+2kTDcs/
         01fwjOzIcYbUdkzjEOOk8eJ4AabDENyJJhPBmjczFn4FPl9yIZ+ZRsRh5HCCdjS2+iAJ
         4f60ggwCFvwvH7EYuBCw8xCw1OBCniRoXPuPWeAIXO4Xw3DeFV7QhbDcc9eX/27ZxOIW
         QCCz6UXUAP4FFA+lFqIFvLk9r46s454jLdeuTCj7DlsnCQeKW+8s7R7iXhydNyPWH1tz
         Du7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M2qNqlVTKQ2zqp8ZwSM77fodaDgRsv8br2tBLgwRw5Y=;
        b=ZMyT888IFgITWRbeJBg4N2vCCiFUQvFkl4l8cX6nv2tGCrbmLyc4gh9a/Ld1ps9CLa
         VXExdkktT+bLUTHzJqcrq5JoD0aqZWZYRumAlJt23pHwPaKn13doXhzXB5VQcJhe52kX
         /ZJ1gLUvzWrqH7Z3jCmpGtwxhQnELIWav8KbVXiIzuqgEoLjOhuiHfW00hYwFW0wqTuN
         uLLv2ZWDeJndpNCiRttEws8xEiJO61+5CTpWnGaOWpPsaB1fJ8/yKe1GS1SrkRmox3or
         ZcTNWaF8IHmV53n7G0igKgASWcor/yn+hLrhNcirmI/BA48l9TqZ+4S7/yZTs5wqpib0
         hSGQ==
X-Gm-Message-State: AOAM532qbVFVi/FFcEv0GlqgBmhmV+dwEcmdQjznjNzA9TiHVodKJCQe
        VZpZeySXuROumY3YROeo2HNwPF1gdip8NA+9QXuJJejkorlgkA==
X-Google-Smtp-Source: ABdhPJwrAUN1GryeVyjGqpVdWqYduVl63/pUKM7kmGbwp9ixmo+bTssTVkeQIUgSUUkcgxo/ZRXB0OwnnzF9oL6yrkw=
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr1050037wmg.70.1603139852328;
 Mon, 19 Oct 2020 13:37:32 -0700 (PDT)
MIME-Version: 1.0
From:   Raymond Bennett <raymond.bennett@gmail.com>
Date:   Mon, 19 Oct 2020 13:37:16 -0700
Message-ID: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
Subject: Constant output in syslog of EDAC message
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

I am seeing the constant output of the following messages in syslog,
wondering what I can do to resolve this:

Oct 19 13:19:30 hostname kernel: EDAC DEBUG: ie31200_check: MC0

It outputs about once every second.

uname -a
Linux hostname 5.9.0-991.native #1 SMP Mon Oct 12 08:10:54 PDT 2020
x86_64 GNU/Linux

/proc/cpuinfo
processor : 7
vendor_id : GenuineIntel
cpu family : 6
model : 158
model name : Intel(R) Xeon(R) CPU E3-1505M v6 @ 3.00GHz
stepping : 9
microcode : 0xd6
