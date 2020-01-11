Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24F9137AD7
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2020 02:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgAKBFA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jan 2020 20:05:00 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39391 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgAKBFA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jan 2020 20:05:00 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so3253377ila.6
        for <linux-edac@vger.kernel.org>; Fri, 10 Jan 2020 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oGchJ2QhW6lEKHr0EcwdcOBniXTxW0gJ/C9Tswq1R5g=;
        b=jPyxKfrPRhG1+zzESdjIpFwo7eC842EPfR2noA0IPLOvFMzR9A5QTsQO2cTEzmwA1e
         iSpf0VAE/ZA87u7BlrdSz/n4xual1ShORNusYdswkmXhlnLxFhYtzkyiHH3tcBGfzTru
         67jC+toBVemvSLle7d9azKvrwpbdnXCejMG8PlDAfQnHiMJulEhmZw7IXXpRDSYOhVC5
         W74Yi9O++enJJ7nukEqpfna7zY0Q0tlTAoaxjvKkZ3+h8IgZdAeY3V/CJ9s57gEwHCre
         SNhQOAmt+4X+PZNI/ULOOYlbtAwkHJogQbtNDgPAFAQdOCYJH2Llfs58mnVum5OsJBCk
         uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oGchJ2QhW6lEKHr0EcwdcOBniXTxW0gJ/C9Tswq1R5g=;
        b=Lk9Ea4af2CMxqMLOi293EcXfz8rTsCTx6dSsP2U+H4EEfVDeDsrXqzBrqgQVWupVnd
         EBiLvvWFfLyK/lgj/evGpb8kI9bcQnos8nkRr/4Qh/wEs8oHsBT0KY7PJ2Ijd+rtvFVy
         311RftrSVh256DSCX6SJXuXNVh8HtBQOTVsoDx/EIaAiCsdJOJGEFYKlvEiLtWvgJRxQ
         qK/uNk3/2emv48mW1mvYGdOJGhUqWAxJDL6i2rMgNjP0Xq3+iQaYY6Xd48F5LOVJjjm+
         1pnvuUpOaij0lDprgIo2YKtcpryPeW7r07FCxYDys9LdbBaqev7IR1tDrdKQUmyrT6Hj
         spIQ==
X-Gm-Message-State: APjAAAX2joiXD6INpDm4ZsJInKXPkavcoH3OyVVXoVDb0dYahvPWLmhz
        WXrPFwGxMYeKKbZCvZGfDa9HhA==
X-Google-Smtp-Source: APXvYqzopQQofRLrTlQmFON2Y7R+LIl8tdlZalcACPY9NCb/x3as6rU2+Xn7Ke3eGOWVov5gfP96dQ==
X-Received: by 2002:a92:914a:: with SMTP id t71mr5417305ild.293.1578704699180;
        Fri, 10 Jan 2020 17:04:59 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b1sm1190156ilc.33.2020.01.10.17.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:04:58 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:04:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.h to include/soc
In-Reply-To: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001101704440.32308@viisi.sifive.com>
References: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 7 Jan 2020, Yash Shah wrote:

> The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> moves the sifive L2 cache driver to driver/soc. It did not move the
> header file along with the driver. Therefore this patch moves the header
> file to driver/soc
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, queued for v5.5-rc.


- Paul
