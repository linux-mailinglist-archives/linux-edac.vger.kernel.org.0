Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAA32EEC1
	for <lists+linux-edac@lfdr.de>; Fri,  5 Mar 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCEPZX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 Mar 2021 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhCEPZI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 5 Mar 2021 10:25:08 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F76DC061574
        for <linux-edac@vger.kernel.org>; Fri,  5 Mar 2021 07:25:08 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so2330693ilc.3
        for <linux-edac@vger.kernel.org>; Fri, 05 Mar 2021 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jTVlfIINqTw0v4Efkeelt0x7KWMArOQ/VsKT2nrF4AQ=;
        b=LoXdWXzlkxmcuLuW5nSQvRR3PpiF9z29YHvlYQC0gvrGOejGX/4/j9LBcN3uJh3kci
         xNJPablV14VkwvhzSA1zBaXivMfcVz0VGym0iZ/idIZUZYtTfYM9jpYdD6wikJKYmxyO
         rUQKkVfs6l3XnZYiL6gJWnnOzRBDXuB9/NSHW7SpQ1go3rLAtBL2O6peDCcqfDQfJP1l
         wCe4fyzSWUFPPeKVmLorJUINZcqDFqpOec+e2zjh6kcRe9wnQI8B61dZ518SiKom+ZcD
         3AJzqKy3rs2Zeg1nZhLC1SJHkD5L4eRrRAczMegth9qTagxREqFCrMOIkSPK0lzXRU5H
         vtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=jTVlfIINqTw0v4Efkeelt0x7KWMArOQ/VsKT2nrF4AQ=;
        b=bHO14TATl5+rxFXwLtwKgYeFFaYdxefNC9Ow/L8zyG1yHCDjTTKn2gYNCb8N65BWLR
         RibaVR1ykfve5npf3G26sK845u/4omTgzwi+7pFc+ZhiDjKSNsRGW1NwklznXHqyuAVx
         Oy8WrsJFYp/jo220hEr7CemwCLhu0TfknMCHF5G4M8FtVuT3XPTWxN2W2o3d4bkUCKUl
         QXLZ9p8bIi07xuxLsXex+hNjfjyVLOV7yth/rLPUWBpsN0n5H5WreOK3Mr95E0s6fuj0
         FcapjXVh7Jt84C5k+WCFLLXU6fOpnvY71QYon8zu/R1HYptWQPXEvBYVl2OTddFytvNC
         Qvdw==
X-Gm-Message-State: AOAM531aWvsqlMBMzuuvwMqmKmufB4Gcb7J0czOjGi0M2kYdTKOgrSyx
        e5c2B3+9DyGOQU5N0GB3u80GXqVREVGx0wrhwWo=
X-Google-Smtp-Source: ABdhPJxFIZTxTpyQVHcDmgTtJ9j991QnqCfk6UH5+z4EhrUJuGT+YWdXlDqCaSpH1J2zgq5ZmYsX4eavTRc0yU/+erE=
X-Received: by 2002:a92:c04b:: with SMTP id o11mr8958247ilf.42.1614957907642;
 Fri, 05 Mar 2021 07:25:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:3f4c:0:0:0:0:0 with HTTP; Fri, 5 Mar 2021 07:25:07 -0800 (PST)
Reply-To: charlesjacksonjrc@gmail.com
From:   Charles Jackson Jr <drsweetspirit@gmail.com>
Date:   Fri, 5 Mar 2021 07:25:07 -0800
Message-ID: <CAPY1kPNtn1ETM69J-RvNwR-hFPnwJnEY0iRjHdDGsX_PG3RrHQ@mail.gmail.com>
Subject: =?UTF-8?Q?Antworte_zur=C3=BCck_f=C3=BCr_den_sofortigen_Anspruch_auf_de?=
        =?UTF-8?Q?in_gespendetes_Geld_und_gratuliere_dir_=2E=2E=2E=2E=2E=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--=20
IHR E-MAIL-KONTO WURDE F=C3=9CR EINE SPENDE VON 3.500.000,00 USD F=C3=9CR
CHARITY AUSGEW=C3=84HLT. Antworten Sie auf die folgende E-Mail, um weitere
Informationen zu erhalten

E-Mail: charlesjacksonjrc@gmail.com
