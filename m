Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C141376B29
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhEGUdf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhEGUde (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 May 2021 16:33:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5768C061574;
        Fri,  7 May 2021 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7uEo0yILZDktWTcgQe09bvJOkPNWx/Z2YDd+juoo00A=; b=ySbdN6IygKSvlxitmXwnD6+FSy
        u6loF7+xVFRTyc6Q1Z/edgACQrPUNDAl71Nk5xm3Bmay0D6lTEavUv9ROwG7Ul+sF8deO1pQSXVaN
        g31xbvabnNN5uj9mzljr8cR+FkuSVZqwuaDbZFmUwo+VmEs+xNalCXu3yjTfi63zw9DCXukt3Apy1
        5lFUwqXeg8VvFBM0xRtLdYcujigFRVIvuG6xF7uaFplefRekNPXWl+o8FRLMDXKryhf1Ou16skQj7
        EgVlDiI1Y2oaSgE3UkVsUNRI+CPR20ozio6SuzrtYu5649KQs0lee+zpsLXNyrJ4TApQrn0Lz6bbH
        XcG0iZEQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lf79B-007ASt-CD; Fri, 07 May 2021 20:32:29 +0000
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1bd2362b-9bbd-c813-e678-66119b53859f@infradead.org>
Date:   Fri, 7 May 2021 13:32:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/7/21 12:01 PM, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
...
> 
> Rome:
>   No interleaving
>   Nodes-per-Socket 0 (NPS0)
>   Nodes-per-Socket 1 (NPS1)
>   Nodes-per-Socket 2 (NPS2)
>   Nodes-per-Socket 4 (NPS4)
>   NPS2 w/o hashing
>   NPS4 w/o hashing
> 
> Thanks,
> Yazen

Hi Yazen,

It appears that you need to provide a glossary of acronyms, e.g.:

DF = (Data Fabric ?)
CS =
MCE =
NPS = Nodes per Socket
etc.


thanks.
-- 
~Randy

