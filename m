Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6D421A80
	for <lists+linux-edac@lfdr.de>; Tue,  5 Oct 2021 01:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJDXVi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Oct 2021 19:21:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:63190 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233517AbhJDXVh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 4 Oct 2021 19:21:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="286489837"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="286489837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 16:19:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="521617882"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.96.73]) ([10.209.96.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 16:19:46 -0700
Subject: Re: [PATCH v2 4/7] ABI: sysfs-mce: add a new ABI file
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
 <801a26985e32589eb78ba4b728d3e19fdea18f04.1632994837.git.mchehab+huawei@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <eb2f2771-139f-c949-72a2-13e33059af8a@linux.intel.com>
Date:   Mon, 4 Oct 2021 16:19:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <801a26985e32589eb78ba4b728d3e19fdea18f04.1632994837.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 9/30/2021 2:44 AM, Mauro Carvalho Chehab wrote:
> Reduce the gap of missing ABIs for Intel servers with MCE
> by adding a new ABI file.
>
> The contents of this file comes from:
> 	Documentation/x86/x86_64/machinecheck.rst
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Andi Kleen <ak@linux.intel.com>


