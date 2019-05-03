Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9A13400
	for <lists+linux-edac@lfdr.de>; Fri,  3 May 2019 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfECTZz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 May 2019 15:25:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35205 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECTZz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 May 2019 15:25:55 -0400
Received: by mail-it1-f195.google.com with SMTP id l140so10785377itb.0
        for <linux-edac@vger.kernel.org>; Fri, 03 May 2019 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rWmEMhzliXcvOCRw3oQALFdco9XMzYzIIL0waa/gPso=;
        b=kiSSW7aSQ9bW2r5VTe/j9kH3X7KcjLczLQh7LQZXDPHzWSJ2bRleyY4/rcvXuGGtP8
         h0Cyh08fdlQJAzSNhL1YqT2Kxlb/ota9cE18qbPPYJx7iiGOkRnakf0J0om8ImkSUOYF
         UiaS8qsHn/tiKdxPqd/OkpsImAVBnwBKQ93x4A94EW7b2vqPuzVuY/orAVL0Nwxi4qjS
         /OfVwDpBI0F6eq4eBLrJpZlttYqKhnPrAQs7DmJvWzdbTj/Uih6JMX6P50NbB8i3TRtn
         QhggAYwBHI07vJ3JPo7Vf7CDi5UEsDs2p03KvzViTNWxL1wWURERsP9JeoF6XvCAJTQH
         7s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rWmEMhzliXcvOCRw3oQALFdco9XMzYzIIL0waa/gPso=;
        b=P7VvKpP2Q6IN47qvayjL+6JBeiMQQpN/AMl8BlSilfSUuqGfTo4JE26lyt3DeKWIRZ
         oL1diPEdrJybhXXv0ZGClbWaEgccOH0t1cEjeZtjAcscvFBQBW55TNwN7o/AR6OaPzpY
         SBdYcIbGn5WqMnMwsfcLs+MLvsvyyw3DWgASgzVLs6vxcwUisk7fOgaqY58AIc+PkFHM
         BNlxLgrGYoepn1qt6B3uwDCoSTc5/d2LFtVLxreAIoMhKjSYWO7N6SXbKr3irBqkmlDu
         bJmJrnviKt3MXc+atR/Uc2rQOw7oKNz1a5NWEfYOwum8gptK2A585n491Zn0KzM5lkrQ
         wciQ==
X-Gm-Message-State: APjAAAVaCH9cGPGdIH2d4P2U/6F7QWRjMw6znlRSX/ID38+Cu84bqkak
        3XlTsyWbuZdskcpU9wd9pWSmtA==
X-Google-Smtp-Source: APXvYqxxG9koOb2FwS7bDsvoQXD5LW7BhJWcinIR8CpAmlMsv235RnRXDMhri4HVBO1mTbSuwEB++w==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr8626527itb.122.1556911554423;
        Fri, 03 May 2019 12:25:54 -0700 (PDT)
Received: from localhost (74-95-18-198-Albuquerque.hfc.comcastbusiness.net. [74.95.18.198])
        by smtp.gmail.com with ESMTPSA id o143sm1538223ito.18.2019.05.03.12.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 12:25:53 -0700 (PDT)
Date:   Fri, 3 May 2019 12:25:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     James Morse <james.morse@arm.com>
cc:     Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@sifive.com, bp@alien8.de,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mchehab@kernel.org, sachin.ghadi@sifive.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Subject: Re: [PATCH] edac: sifive: Add EDAC platform driver for SiFive SoCs
In-Reply-To: <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
Message-ID: <alpine.DEB.2.21.9999.1905031206450.4777@viisi.sifive.com>
References: <1556795761-21630-1-git-send-email-yash.shah@sifive.com> <1556795761-21630-2-git-send-email-yash.shah@sifive.com> <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

On Thu, 2 May 2019, James Morse wrote:

> Having an separately posted dependency like this is tricky, as this code can't be
> used/tested until the other bits are merged.

...

> Looks good to me. I think this patch should go with its two dependencies, I'm not sure why
> it got split off...

The split was due to my suggestion to Yash, I think.  The motivation was 
to decouple the L2 cache controller driver's journey upstream from the 
EDAC driver's upstream path.  The patches will go up via separate trees, 
so the idea was to avoid blocking the L2 cache controller driver on the 
EDAC driver review path.

Thanks for your review,


- Paul
