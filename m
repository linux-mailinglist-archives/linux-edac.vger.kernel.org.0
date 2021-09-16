Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59F40EDC3
	for <lists+linux-edac@lfdr.de>; Fri, 17 Sep 2021 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhIPXPO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Sep 2021 19:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241556AbhIPXPF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F4B6120F;
        Thu, 16 Sep 2021 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631834023;
        bh=Ct8BzDiQhEyelaPo0OWbDjNfR2tnMEW48s94JN5yi+o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Sg/Nc/c23vvvzhF5CGMUz0E3b4w6BS6Z5idLkBIE7I9t7LiPoSouYvRns6dhJaWIp
         X8ccvRPqaSAtt4srk3tOabBLzj/io7moyP41c4LMdX0wy/xoaB7qlatZ2DMp5zqdj0
         zTT0Y7kfVDP1pP7BZcJ2E3983jiUYf0C6MezwSAUR+/okCqYdARWUGnoJds1mNwioW
         ctg87EmEhPbuIyMDYFuJixM3EiwPF4WcFtwLsBPwvMlY/gEqLUxTgmg6BgzHlCTJVo
         QbORpxRXnhGr2zFsZsptYINIPApN8SYL27vWpux/aGlNuZGbh2abbXn06e2iiMhfaG
         VhhuU4d4FBfng==
Subject: Re: [PATCH 1/2] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
To:     Borislav Petkov <bp@alien8.de>
Cc:     michal.simek@xilinx.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <20210831200316.3208310-1-dinguyen@kernel.org>
 <YUHcmlo2c4t9MSKK@zn.tnic>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <5b509fb8-b0d3-026b-0a30-a74df45d9332@kernel.org>
Date:   Thu, 16 Sep 2021 18:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUHcmlo2c4t9MSKK@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/15/21 6:44 AM, Borislav Petkov wrote:
> On Tue, Aug 31, 2021 at 03:03:15PM -0500, Dinh Nguyen wrote:
>> This patch adds support for version 3.80a of the Synopsys DDR controller
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 

Sent v2 with a better commit message.

Dinh

