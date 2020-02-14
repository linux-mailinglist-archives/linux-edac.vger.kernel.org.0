Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41B15EDDE
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 18:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbgBNRgs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 12:36:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:39280 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390178AbgBNRgs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Feb 2020 12:36:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 09:36:46 -0800
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="238420888"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 09:36:46 -0800
Date:   Fri, 14 Feb 2020 09:36:44 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Do not log spurious corrected mce errors
Message-ID: <20200214173644.GA7913@agluck-desk2.amr.corp.intel.com>
References: <20200214123407.4184-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214123407.4184-1-prarit@redhat.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 14, 2020 at 07:34:07AM -0500, Prarit Bhargava wrote:
>  #ifdef CONFIG_X86_MCE_AMD
>  extern bool amd_filter_mce(struct mce *m);
> +extern bool intel_filter_mce(struct mce *m);
>  #else

Something very weird is going on here. Why does
CONFIG_X86_MCE_AMD have to be set to enable some
*Intel* filter operation?

-Tony
