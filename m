Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC27434CEA6
	for <lists+linux-edac@lfdr.de>; Mon, 29 Mar 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhC2LSC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Mar 2021 07:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhC2LRf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Mar 2021 07:17:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A0C061574
        for <linux-edac@vger.kernel.org>; Mon, 29 Mar 2021 04:17:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y2so4228209plg.5
        for <linux-edac@vger.kernel.org>; Mon, 29 Mar 2021 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=OX2Cxj32MGETk+rokGtVtEwybyKFoAXeHiI8UpK9Fz6AjXpupg6tvpGLOgCOtMrdkM
         Z17wChLCPdL7wrzOqvbjaHvshPG3rNobPjvUcypw3TwDVMBgqIrW5uffN+T57LtEapLh
         Kvgsfah+Ys2doIGcXe2o+WJQvmk1XxxY8iWolefcJLxUYFMCoP6EjKG5Sn+XDWEOFkTf
         dWpiyl3m+m1HsxN/SDWEwPqlDsE3LSfgRZXe/+fjEGh/nI0pRtJuJzDcDSo8Ox2vN9zz
         CGUxakH5IhTMUM2RkApEGdqqyxSRC3e5qJBEwerH5neAjAy09TB6tpuYrGKK/kz0Dgva
         V+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=nAuvlBNAyXDWlyJQKKNyDDNtE5NBMrzr0G1hdZMdOJf8P7xvDLF+w0S2kWZOr+jYG9
         UWjkQevtNBmvpSfvuoNMzE28aN/RWfKHDZrOamsHBpbdF06QEvQ5/abs79EqimGU8XfB
         sG07XlZTIqrJTqM+7vzjL8GwHgAXrC3nyfuHnb6dEAKkzuZWXXRChq4sbA30zD10jitO
         ETJJ2VSvQomMVU1N2QpvX0dLIqAD+ZV7EC+6cLNE563YgtsnZfkqwdcNZmX6/sgAFhK4
         7LhpP9B/XgaLwzR1Olc5sT18evFYQ+o3To3RCceMeQbGg7kmEXcg2hW/eb6Q03wZRFY+
         bn8A==
X-Gm-Message-State: AOAM532FTPhjKNN56oSR787K8Z+RXC8cITrt2kDbrGG2TYNWl7iSlPhX
        shDxMs+V1+k/Ki+D4PvSG+RF+BLcChtSOaiSyf7nCUxsHik=
X-Google-Smtp-Source: ABdhPJyYslXfTnI4GvobUktHgi+1xpKxvWD2Q91kvLjdtYicbpWV3/3WsyRkj2agG4Q8JkHTKo5j28J0k4LITEFS+zg=
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr25785152pjb.93.1617016652853;
 Mon, 29 Mar 2021 04:17:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:fb8d:0:0:0:0 with HTTP; Mon, 29 Mar 2021 04:17:32
 -0700 (PDT)
Reply-To: sgtmanthey1@gmail.com
From:   kayla manthey <mohamedissaka85@gmail.com>
Date:   Mon, 29 Mar 2021 11:17:32 +0000
Message-ID: <CA+WYczOkXfr8jF4AGLHxOeAy=1NtOub0XHUHamWd58CgNDxVrA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Vennligst jeg vil vite om du har mine tidligere meldinger.
