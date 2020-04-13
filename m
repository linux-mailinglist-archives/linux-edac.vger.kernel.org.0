Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAB1A6614
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgDMMAu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 08:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDMMAu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 08:00:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3BC03BC81;
        Mon, 13 Apr 2020 05:00:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so5560536wrq.2;
        Mon, 13 Apr 2020 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RBJ/82khCb7w6F9uDzE2PbYYqeQUKGyIpJAUYpqNKF4=;
        b=GsJNe0fBOEgYAfjdnslyVvoC/js7vUPKIw0Bgmny6X9rtvRxR4O63StFcb8M3t/cbn
         dkcOuXB7e127Zc2j6rBvehWVxrUNIN5OyAA/JWvQQ+AerGoG2kmwgXA8IJRrJZW+U6d7
         9aDfC4kNAZ06MxbIYMJltKCgGZgCZmfTAwmrvxhuoTNnwUPxOfSd5swZtF1zIJsCcOEM
         LBv3SsbCbnHQHhIJ0Uq4/fuZfhYwmwZDls6ZmZZa6I4HGaivcnMrL5fD/POT1OQukjfL
         5GUu52r4pwktExzbSeRxM4XkyALb5/DMbhmTeuWFH+ri0daBUhFUIIwHEV//g0a1JXHa
         Apxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RBJ/82khCb7w6F9uDzE2PbYYqeQUKGyIpJAUYpqNKF4=;
        b=qwJuqXT4PBGopvkIQVUrf+ZbOrPFERmarEw4V9v0JnkwNVoe6LsSlChVmsvHPKVhE+
         ncqzjqztZMp4FAdWmeK9cIazIYxezzOfxMxDefzXi0jnkODjD37kbZuk5qD620F3j4Z4
         J1uHVsDGcVU+rshRRlEvaEz385Mt+q4nURXvhGricw241cFaUyG9/u0hZnHWMILOAthV
         YHW3/FStBftLgEvfMtiMXqceZS4yyGgSdXYRkZ99Pfa26LE3R9Dm6lO71wNXYpbWae3i
         Z6DANwumFIpA+NVh+SToP86fqix0nQgk/LNvPFa9rdPeoDEIjJRhCwJtqYFZjZoycoOZ
         4O4w==
X-Gm-Message-State: AGi0Pube5g1+5TxpgetQf4C5R5JIYalQkGEIMHKVkZKvs+xRfoikwmjT
        pBAW3yon2NMXAA5UnO1KvWc=
X-Google-Smtp-Source: APiQypKDPM7kNBa5oaqSMMFFVeqs0gfTJlQ9GtmtfAaxc2WuSh+Un8+F1RME4b+yHb37sCo73UY9bA==
X-Received: by 2002:adf:a11a:: with SMTP id o26mr14294203wro.284.1586779247648;
        Mon, 13 Apr 2020 05:00:47 -0700 (PDT)
Received: from felia ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id x11sm14651007wru.62.2020.04.13.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:00:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 13 Apr 2020 14:00:39 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Borislav Petkov <bp@alien8.de>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: rectify EDAC-SIFIVE entry
In-Reply-To: <20200413081556.GB3772@zn.tnic>
Message-ID: <alpine.DEB.2.21.2004131358020.7282@felia>
References: <20200413073447.9284-1-lukas.bulwahn@gmail.com> <20200413081556.GB3772@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Mon, 13 Apr 2020, Borislav Petkov wrote:
> 
> Looking at that a bit - I think the right thing to do is to remove that
> sifive_l2_cache.c file from the EDAC-SIFIVE file pattern because the
> edac driver is simply using the L2 thing to register on its notifier
> chain, i.e., using an external facility, like all the drivers do. And the
> l2_cache thing is not part of the edac driver.
> 

Thanks for the pointer.

I adjusted the patch, first accidently sent a broken PATCH v2 (which 
shall be ignored), but this PATCH v3 shall be picked:

https://lore.kernel.org/lkml/20200413115255.7100-1-lukas.bulwahn@gmail.com/


Lukas
