Return-Path: <linux-edac+bounces-4120-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E073AD77FE
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9243A0755
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C829DB6E;
	Thu, 12 Jun 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cb58meQa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53B23026B;
	Thu, 12 Jun 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744903; cv=none; b=DPZQIt8YkmU/fGYpcFxDMdW3zXPw7LiR+2a3AUj8ln6OtEKU1L6uqxVdCGxQOTxTDe4vMGQtF+n4GhmSCy/3R33MhYNKCfQDYLolOv06wE7uARNIRKJqBqzVsILSsr70UwSQfdRLOZXd4LmKabWDF0jyk/3ISXDpXZFVoOX0Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744903; c=relaxed/simple;
	bh=j9dHCfR61zJv1bBAavSABckZ8ziVHjZSd9lKDPsxLKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2WhOEVHpIepbBO6Vlj8ZjG6wVnImk/vsQ8J4yUvRrWTmFsj+AaQ8Rv5dpicTnperhd5GQlnp8CgYwVH8tjbcB5fXcuBVVLhFNw6hwF205Ez5wWFyNx8dwEu7OHvg1ZT/IEBnN+2T3Wjt6Ge0UsKzRjvEkBg87qCZ4NIW78HaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cb58meQa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8589A40E016E;
	Thu, 12 Jun 2025 16:14:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPo35jQCHO70; Thu, 12 Jun 2025 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1749744892; bh=G81B13AGBkDrjM176tc3zsIP4c1VrBnBegshc5rd/4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cb58meQaJBswr4e49MzIndfxacpUT5LNxnqw/dUrs9Y+Tm8iZQs47tiyKkOnJsxqp
	 Z0fP9OUFYzCmuQlk4BM9NdDU9Wcqqi2MPmz80soOq0clzEHnqUtw228ZsUf1a3PIe2
	 L38Rl7XXrxNfQeJlhM6KsjHM7J6/PikXHGtsyddVnUnkIAGN+qGRLTCSetUyIVvwtB
	 Su3bk2kR0EzAxGTAWcQUiZBQQOXogmgpFMtmRFXzBWCCHkRf1F6n6TsroczbKhMQg0
	 j+QrPv38vcM5/Lw0Who64w6QieeC4HTeRLVaqeQ8YvaqZWILEsdwhoKN5bUxE/EFp4
	 Jl8r9Zjm+qEoZf5yh5S63JvzGH/TX8Ww0DHQrRn1+y7Sxbre8enQS0BwCuItT/Qgys
	 6lRLbxoK4lENhhjON8eYy1No59ry5YEMDaG2NBaVOKrkh049Ftirwz8Kv97M41cZYF
	 DwBYLOkrhsBBIwgtw6q7EDhLuO87YGJGDtcZcTKA6VIZ2cm9pkfJb9Wv1zkwNhz7Ff
	 H+uplzlYv+mZHZNtaormDQ+agZMLJNk01ti1uPOtzv/h9pGfyDD7ZhjQ1FvdklfFEW
	 x6c2f2P+ytQ9HJmOUr76/12AutrjYGwo9i7KkGINuqr0BoF6PD5bfDExT9vL+jdRXo
	 lCeC89djme1AiWanCxp0OHTM=
Received: by mail.alien8.de (SuperMail on ZX Spectrum 128k, from userid 1005)
	id 6BC0F40E0184; Thu, 12 Jun 2025 16:14:52 +0000 (UTC)
Date: Thu, 12 Jun 2025 16:14:52 +0000
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	linux-edac@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] tracing, AER: Hide PCIe AER event when PCIEAER is not
 configured
Message-ID: <20250612161452.GAaEr8/PdA2jeKC7ld@fat_crate.local>
References: <20250612094932.4a08abd6@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250612094932.4a08abd6@batman.local.home>

On Thu, Jun 12, 2025 at 09:49:32AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The event aer_event is only used when CONFIG_PCIEAER is configured. It
> should not be created when it is not. When an event is created it creates
> around 5K of text and meta data regardless if the tracepoint is used or
> not. Instead of wasting this memory, put #ifdef around the event to not
> create it when it is not used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, I will be adding code soon that will make unused events cause a warning.
> 
>  include/ras/ras_event.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 14c9f943d53f..c8cd0f00c845 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -252,6 +252,7 @@ TRACE_EVENT(non_standard_event,
>  		  __print_hex(__get_dynamic_array(buf), __entry->len))
>  );
>  
> +#ifdef CONFIG_PCIEAER
>  /*
>   * PCIe AER Trace event
>   *
> @@ -337,6 +338,7 @@ TRACE_EVENT(aer_event,
>  			__print_array(__entry->tlp_header, PCIE_STD_MAX_TLP_HEADERLOG, 4) :
>  			"Not available")
>  );
> +#endif /* CONFIG_PCIEAER */
>  
>  /*
>   * memory-failure recovery action result event
> -- 

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>


