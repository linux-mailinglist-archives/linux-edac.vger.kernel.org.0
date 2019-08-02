Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D77FF2C
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbfHBRET (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 13:04:19 -0400
Received: from foss.arm.com ([217.140.110.172]:55160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbfHBRET (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 13:04:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C34BA1570;
        Fri,  2 Aug 2019 10:04:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007C73F819;
        Fri,  2 Aug 2019 10:04:17 -0700 (PDT)
Subject: Re: [PATCH v6 11/57] edac: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-12-swboyd@chromium.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <aae0a829-3865-a40e-1c9e-191189dd7aab@arm.com>
Date:   Fri, 2 Aug 2019 18:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730181557.90391-12-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 30/07/2019 19:15, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong.

I assume this is part of a series that makes this the case...


> Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>

> While we're here, remove braces on if statements that only have one
> statement (manually).

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
