Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E506ED474
	for <lists+linux-edac@lfdr.de>; Mon, 24 Apr 2023 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDXSdi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Apr 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXSdi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Apr 2023 14:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FAFA;
        Mon, 24 Apr 2023 11:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A60D61FE0;
        Mon, 24 Apr 2023 18:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03BC433EF;
        Mon, 24 Apr 2023 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682361215;
        bh=Bh+10+R3A/yUQVhtOX/56s3HJOtp4DKkx4sNUEErKqI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K2qtgyjfQzoJsdZwFY+Z8dajn+4FwW1qHO0zlgC4/Om0UZYeLDnc9VnVFcAeYxRN5
         4UlCmDfDyYIi8D+cUhNVXL9o04fuv1BdsQPAeiQV4HJEbnnBWm72mfZfudkFsT8kla
         vTJxyC8xP5FaUtAc6N8RisRYDEGr3YoOz13+hO/+SG/e/DpWA6jbQ8GJVxzXeQj0vZ
         XYfOeFRRou/0BubvyVx+H6wRIM0uMaBU4TaiN1jRWad9dztKaV801DjQGcuAA9TQiS
         unoUAvxmwaLADorytx99TGIXqdr5/TaRo/XEYpiRJnGtzcpU18ahI/Eo1okn2hladz
         Rd9ykCvyIZ4bA==
Message-ID: <25e2f220-488b-1c71-3a18-7b6252f777ad@kernel.org>
Date:   Mon, 24 Apr 2023 13:33:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] EDAC: Use of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327201411.529948-1-robh@kernel.org>
 <20230418164016.GA1823469-robh@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230418164016.GA1823469-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 4/18/23 11:40, Rob Herring wrote:
> On Mon, Mar 27, 2023 at 03:14:11PM -0500, Rob Herring wrote:
>> Replace of_get_address() and of_translate_address() calls with single
>> call to of_address_to_resource().
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> v2:
>>   - Fix compile error
>> ---
>>   drivers/edac/altera_edac.c |  5 +++--
>>   drivers/edac/ti_edac.c     | 10 +++++-----
>>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> Ping!
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
